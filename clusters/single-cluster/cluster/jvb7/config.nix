{ config, pkgs, lib, ... }:
{
  imports = [
    ../../environments/base.nix
        <vpsadminos/os/lib/nixos-container/vpsadminos.nix>

  ];
  networking.hostName = "jvb7";
  networking.useDHCP = false;
  services.resolved.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=900s
  '';
  systemd.services.systemd-udev-trigger.enable = false;

  # ... standard NixOS configuration ...
    networking.firewall.enable = false;
        services.prometheus.exporters.jitsi.enable = true;
       services.prometheus.exporters.node.enable  = true;
      services.prometheus.exporters.node.enabledCollectors  = [ "systemd"];
    services.jitsi-videobridge = {
        apis = [ "colibri" "rest" ] ;
        enable = true;
        xmppConfigs."meet-nixos.vpsfree.cz" = {
            domain = "auth.meet-nixos.vpsfree.cz";
            hostName = "meet-nixos.vpsfree.cz";
            userName = "jvb";
            mucNickname = "meet7";
            disableCertificateVerification = true;
            passwordFile = "/secrets/jitsi-meet/videobridge-secret";
            mucJids = "jvbbrewery@internal.meet-nixos.vpsfree.cz";
        };
        openFirewall = true;
    };

}
