# frozen_string_literal: true

require 'yaml'

module Overcommit
  # Manages configuration file loading.
  class ConfigurationLoader
    DEFAULT_CONFIG_PATH = File.join(Overcommit::HOME, 'config', 'default.yml')

    class << self
      # Loads and returns the default configuration.
      #
      # @return [Overcommit::Configuration]
      def default_configuration
        @default_configuration ||= load_from_file(DEFAULT_CONFIG_PATH, default: true, verify: false)
      end

      # Loads configuration from file.
      #
      # @param file [String] path to file
      # @param options [Hash]
      # @option default [Boolean] whether this is the default built-in configuration
      # @option verify [Boolean] whether to verify the signature of the configuration
      # @option logger [Overcommit::Logger]
      # @return [Overcommit::Configuration]
      def load_from_file(file, options = {})
        # Psych 4 introduced breaking behavior that doesn't support aliases by
        # default. Explicitly enable aliases if the option is available.
        yaml =
          begin
            YAML.load_file(file, aliases: true)
          rescue ArgumentError
            YAML.load_file(file)
          end

        hash = yaml ? yaml.to_hash : {}
        Overcommit::Configuration.new(hash, options)
      end
    end

    # Create a configuration loader which writes warnings/errors to the given
    # {Overcommit::Logger} instance.
    #
    # @param logger [Overcommit::Logger]
    # @param options [Hash]
    # @option verify [Boolean] whether to verify signatures
    def initialize(logger, options = {})
      @log = logger
      @options = options
    end

    # Loads and returns the configuration for the repository we're running in.
    #
    # @return [Overcommit::Configuration]
    def load_repo_config
      overcommit_local_yml = File.join(Overcommit::Utils.repo_root,
                                       Overcommit::LOCAL_CONFIG_FILE_NAME)
      overcommit_yml = File.join(Overcommit::Utils.repo_root,
                                 Overcommit::CONFIG_FILE_NAME)

      if File.exist?(overcommit_local_yml) && File.exist?(overcommit_yml)
        load_file(overcommit_yml, overcommit_local_yml)
      elsif File.exist?(overcommit_yml)
        load_file(overcommit_yml)
      else
        self.class.default_configuration
      end
    end

    # Loads a configuration, ensuring it extends the default configuration.
    def load_file(file, local_file = nil)
      overcommit_config = self.class.load_from_file(file, default: false, logger: @log)
      l_config = self.class.load_from_file(local_file, default: false, logger: @log) if local_file
      config = self.class.default_configuration.merge(overcommit_config)
      config = config.merge(l_config) if l_config

      if @options.fetch(:verify) { config.verify_signatures? }
        verify_signatures(config)
      end

      config
    rescue Overcommit::Exceptions::ConfigurationSignatureChanged
      raise
    rescue StandardError => e
      raise Overcommit::Exceptions::ConfigurationError,
            "Unable to load configuration from '#{file}': #{e}",
            e.backtrace
    end

    private

    def verify_signatures(config)
      if !config.previous_signature?
        raise Overcommit::Exceptions::ConfigurationSignatureChanged,
              "No previously recorded signature for configuration file.\n" \
              'Run `overcommit --sign` if you trust the hooks in this repository.'

      elsif config.signature_changed?
        raise Overcommit::Exceptions::ConfigurationSignatureChanged,
              "Signature of configuration file has changed!\n" \
              "Run `overcommit --sign` once you've verified the configuration changes."
      end
    end
  end
end
