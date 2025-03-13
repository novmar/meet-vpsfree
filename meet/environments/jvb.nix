{ config, pkgs, lib, ... }:
{
    networking.nat.externalInterface = "venet0";

    networking.firewall =  {
       enable = false;
       allowedTCPPorts = [
            443 # for forward to jitsi
            5443
            9700 # port for jitsi-exporter
            9100 # port for prometheus node-exporter
            ];
    };

  networking.useDHCP = false;
  services.resolved.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=900s
  '';
  systemd.services.systemd-udev-trigger.enable = false;

  # ... standard NixOS configuration ...

    services.prometheus.exporters.jitsi.enable = true;
    services.prometheus.exporters.node.enable  = true;
#    services.prometheus.exporters.node.enabledCollectors  = [ "systemd" ];
    services.jitsi-videobridge = {
        openFirewall = true;
        enable = true;
          colibriRestApi = true;
          config = {
            videobridge = {
            TCP_HARVESTER_PORT=443;
            ice.harvest.NAT_HARVESTER_LOCAL_ADDRESS = "${config.cluster."${config.networking.hostName}".host.target}";
            ice.tcp = {
                enabled = true;
                port = 443;
                };
            server-id = config.networking.hostName;
            };
        };
        xmppConfigs."meet.vpsfree.cz" = {
            domain = "auth.meet.vpsfree.cz";
            hostName = "meet.vpsfree.cz";
            userName = "jvb";
            mucNickname = "${config.networking.hostName}";
            disableCertificateVerification = true;
            passwordFile = "/secrets/jitsi-meet/videobridge-secret";
            mucJids = "jvbbrewery@internal.auth.meet.vpsfree.cz";
        };
    };

}
