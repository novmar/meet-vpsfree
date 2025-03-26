# frozen_string_literal: true

require 'overcommit'
require 'optparse'

module Overcommit
  # Responsible for parsing command-line options and executing appropriate
  # application logic based on those options.
  class CLI # rubocop:disable Metrics/ClassLength
    def initialize(arguments, input, logger)
      @arguments = arguments
      @cli_options = {}
      @input     = input
      @log       = logger
      @options   = {}

      Overcommit::Utils.log = logger
    end

    def run
      parse_arguments

      case @options[:action]
      when :install, :uninstall
        install_or_uninstall
      when :template_dir
        print_template_directory_path
      when :sign
        sign
      when :run_all
        run_all
      when :diff
        diff
      end
    rescue Overcommit::Exceptions::ConfigurationSignatureChanged => e
      puts e
      exit 78 # EX_CONFIG
    rescue Overcommit::Exceptions::HookContextLoadError => e
      puts e
      exit 64 # EX_USAGE
    end

    private

    attr_reader :log

    def parse_arguments
      @parser = create_option_parser

      begin
        @parser.parse!(@arguments, into: @cli_options)

        # Default action is to install
        @options[:action] ||= :install

        # Unconsumed arguments are our targets
        @options[:targets] = @arguments
      rescue OptionParser::InvalidOption => e
        print_help @parser.help, e
      end
    end

    def create_option_parser
      OptionParser.new do |opts|
        opts.banner = "Usage: #{opts.program_name} [options] [target-repo]"

        add_information_options(opts)
        add_installation_options(opts)
        add_other_options(opts)
      end
    end

    def add_information_options(opts)
      opts.on_tail('-h', '--help', 'Show this message') do
        print_help opts.help
      end

      opts.on_tail('-v', '--version', 'Show version') do
        print_version(opts.program_name)
      end

      opts.on_tail('-l', '--list-hooks', 'List installed hooks') do
        print_installed_hooks
      end
    end

    def add_installation_options(opts)
      opts.on('-u', '--uninstall', 'Remove Overcommit hooks from a repository') do
        @options[:action] = :uninstall
      end

      opts.on('-i', '--install', 'Install Overcommit hooks in a repository') do
        @options[:action] = :install
      end

      opts.on('-f', '--force', 'Overwrite any previously installed hooks') do
        @options[:force] = true
      end

      opts.on('-r [hook]', '--run [hook]', 'Run specified hook against all git tracked files. Defaults to `pre_commit`.') do |arg| # rubocop:disable Layout/LineLength
        @options[:action] = :run_all
        @options[:hook_to_run] = arg ? arg.to_s : 'run-all'
      end

      opts.on('--diff [ref]', 'Run pre_commit hooks against the diff between a given ref. Defaults to `main`.') do |arg| # rubocop:disable Layout/LineLength
        @options[:action] = :diff
        arg
      end
    end

    def add_other_options(opts)
      opts.on('-s', '--sign [hook]', 'Update hook signatures', String) do |hook_to_sign|
        @options[:hook_to_sign] = hook_to_sign if hook_to_sign.is_a?(String)
        @options[:action] = :sign
      end

      opts.on('-t', '--template-dir', 'Print location of template directory') do
        @options[:action] = :template_dir
      end
    end

    def install_or_uninstall
      if Array(@options[:targets]).empty?
        @options[:targets] = [Overcommit::Utils.repo_root].compact
      end

      if @options[:targets].empty?
        log.warning 'You are not in a git repository.'
        log.log 'You must either specify the path to a repository or ' \
                'change your current directory to a repository.'
        halt 64 # EX_USAGE
      end

      @options[:targets].each do |target|
        Installer.new(log).run(target, @options)
      rescue Overcommit::Exceptions::InvalidGitRepo => e
        log.warning "Invalid repo #{target}: #{e}"
        halt 69 # EX_UNAVAILABLE
      rescue Overcommit::Exceptions::PreExistingHooks => e
        log.warning "Unable to install into #{target}: #{e}"
        halt 73 # EX_CANTCREAT
      end
    end

    def print_template_directory_path
      puts File.join(Overcommit::HOME, 'template-dir')
      halt
    end

    def print_help(message, error = nil)
      log.error "#{error}\n" if error
      log.log message
      halt(error ? 64 : 0) # 64 = EX_USAGE
    end

    def print_version(program_name)
      log.log "#{program_name} #{Overcommit::VERSION}"
      halt
    end

    # Prints the hooks available in the current repo and whether they're
    # enabled/disabled.
    def print_installed_hooks
      config.all_hook_configs.each do |hook_type, hook_configs|
        print_hooks_for_hook_type(config, hook_configs, hook_type)
      end

      halt
    end

    def print_hooks_for_hook_type(repo_config, hook_configs, hook_type)
      log.log "#{hook_type}:"
      hook_configs.each do |hook_name, config|
        log.partial "  #{hook_name}: "

        if config['enabled']
          log.success('enabled', true)
        else
          log.error('disabled', true)
        end

        if repo_config.plugin_hook?(hook_type, hook_name)
          log.warning(' (plugin)')
        else
          log.newline
        end
      end
    end

    def sign
      if @options[:hook_to_sign]
        context = Overcommit::HookContext.create(@options[:hook_to_sign],
                                                 config,
                                                 @arguments,
                                                 @input)
        Overcommit::HookLoader::PluginHookLoader.new(config,
                                                     context,
                                                     log).update_signatures
      else
        log.log 'Updating signature for configuration file...'
        config(verify: false).update_signature!
      end

      halt
    end

    def run_all
      empty_stdin = File.open(File::NULL) # pre-commit hooks don't take input
      context = Overcommit::HookContext.create(@options[:hook_to_run], config, @arguments, empty_stdin) # rubocop:disable Layout/LineLength
      config.apply_environment!(context, ENV)

      printer = Overcommit::Printer.new(config, log, context)
      runner  = Overcommit::HookRunner.new(config, log, context, printer)

      status = runner.run

      halt(status ? 0 : 65)
    end

    def diff
      empty_stdin = File.open(File::NULL) # pre-commit hooks don't take input
      context = Overcommit::HookContext.create('diff', config, @arguments, empty_stdin, **@cli_options) # rubocop:disable Layout/LineLength
      config.apply_environment!(context, ENV)

      printer = Overcommit::Printer.new(config, log, context)
      runner  = Overcommit::HookRunner.new(config, log, context, printer)

      status = runner.run

      halt(status ? 0 : 65)
    end

    # Used for ease of stubbing in tests
    def halt(status = 0)
      exit status
    end

    # Returns the configuration for this repository.
    def config(options = {})
      @config ||= Overcommit::ConfigurationLoader.new(log, options).load_repo_config
    end
  end
end
