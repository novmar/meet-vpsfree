{ config, pkgs, lib, ... }:
{
  imports = [
    ../../environments/base.nix
        <vpsadminos/os/lib/nixos-container/vpsadminos.nix>

  ];
  networking.hostName = "jvb5";
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
        xmppConfigs."meet-vpsfree.vpsfree.cz" = {
            domain = "auth.meet-vpsfree.vpsfree.cz";
            hostName = "meet-vpsfree.vpsfree.cz";
            userName = "jvb";
            mucNickname = "meet5";
            disableCertificateVerification = true;
            passwordFile = "/secrets/jitsi-meet/videobridge-secret";
            mucJids = "jvbbrewery@internal.meet-vpsfree.vpsfree.cz";
        };
        openFirewall = true;
    };

}
