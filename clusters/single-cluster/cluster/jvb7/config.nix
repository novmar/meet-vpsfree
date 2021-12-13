{ config, pkgs, lib, ... }:
{
  imports = [
        ../../environments/base.nix
        ./module.nix
        <vpsadminos/os/lib/nixos-container/vpsadminos.nix>

  ];
  networking.hostName = "jvb7";
    networking.nat.externalInterface = "venet0";

    networking.nat = {
        enable = true ;
        forwardPorts = [
            {
            destination = "${config.cluster."${config.networking.hostName}".host.target}:4443";


            proto = "tcp" ;
            sourcePort = 443;
            }
        ];

    };
    networking.firewall =  {
       enable = true;
       allowedTCPPorts = [
            443 # for forward to jitsi
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
    services.prometheus.exporters.node.enabledCollectors  = [ "systemd"];
    services.jitsi-videobridge = {
        apis = [ "colibri" "rest" ] ;
        enable = true;
        config = {
            videobridge = {
            TCP_HARVESTER_MAPPED_PORT = 443;
            TCP_HARVESTER_PORT=4443;
            ice.harvest.NAT_HARVESTER_LOCAL_ADDRESS = "${config.cluster."${config.networking.hostName}".host.target}";
            ice.tcp = {
            enabled = true;
            port = 4443;
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
            mucJids = "jvbbrewery@internal.meet.vpsfree.cz";
        };
        openFirewall = true;
    };

}
