{ config, pkgs, lib, ... }:
{
  imports = [
    ../../environments/base.nix
        <vpsadminos/os/lib/nixos-container/vpsadminos.nix>

  ];
  networking.hostName = "jvb1";
  networking.useDHCP = false;
  services.resolved.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=900s
  '';
  systemd.services.systemd-udev-trigger.enable = false;

  # ... standard NixOS configuration ...
    networking.firewall.enable = false;
    services.jitsi-videobridge = {
        enable = true;
        xmppConfigs."meet-dev.vpsfree.cz" = {
            domain = "auth.meet-dev.vpsfree.cz";
            hostName = "meet-dev.vpsfree.cz";
            userName = "jvb";
            mucNickname = "meet1";
            disableCertificateVerification = true;
            passwordFile = "/var/lib/jitsi-meet/videobridge-secret";
            mucJids = "jvbbrewery@internal.meet-dev.vpsfree.cz";
        };
        openFirewall = true;
    };

}