{ config, pkgs, confData, ... }:
{
  imports = [
    <vpsadminos/os/lib/nixos-container/unstable/vpsadminos.nix>
  ];

  time.timeZone = "Europe/Prague";

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = with confData.sshKeys; admins;

  environment.systemPackages = with pkgs; [
    vim
    screen
    htop
    mc
  ];

  networking.useDHCP = false;
  services.resolved.enable = false;
  systemd.settings.Manager.DefaultTimeoutStartSec = "900s";

  services.prometheus.exporters.node = {
    enable = true;
    disabledCollectors = [ "powersupplyclass" ]; # /sys/class/power_supply is denied in containers
  };

  # Prometheus scrapers (vpsFree monitoring) live in 172.16.4.0/24. Exporters' own
  # firewallFilter goes through ip46tables, which rejects an IPv4 source.
  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -p tcp -s 172.16.4.0/24 -m multiport --dports 9100,9700 -j nixos-fw-accept
  '';
}
