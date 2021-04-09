{ config, pkgs, lib, ... }:
{
  imports = [
    ../../environments/base.nix
        <vpsadminos/os/lib/nixos-container/vpsadminos.nix>

  ];
  networking.hostName = "master0";
  networking.useDHCP = false;

  services.resolved.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=900s
  '';
  systemd.services.systemd-udev-trigger.enable = false;

  # ... standard NixOS configuration ...
    services.prosody = {
    xmppComplianceSuite = false;
        enable = true ;
        virtualHosts."node0" = {
                enabled = true;
                domain = "jtisi0.marnov.cz";
                extraConfig = ''
                authentication = "internal_hashed";
                '';

        };
    };
}
