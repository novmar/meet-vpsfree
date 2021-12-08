{ config, pkgs, lib, ... }:
{
  imports = [
    ../../environments/base.nix
        <vpsadminos/os/lib/nixos-container/vpsadminos.nix>
  ];
  networking.hostName = "meet";
  networking.useDHCP = false;

  services.resolved.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStartSec=900s
  '';
  systemd.services.systemd-udev-trigger.enable = false;
  # ... standard NixOS configuration ...

#  networking.firewall.enable = false;

  security.acme.acceptTerms = true ;
  security.acme.email = "acme@marnov.cz";

    # nginx
    services.nginx.recommendedProxySettings = true;
    services.nginx.virtualHosts."meetone.macabara.cz" = {
        locations = {
            "=/xmpp-websocket" = {
                proxyPass = "http://meetone.macabara.cz:5280/xmpp-websocket";
                proxyWebsockets = true ;
                extraConfig = ''
                proxy_read_timeout 900s;
                proxy_buffer_size 128k;
                proxy_buffers 4 256k;
                proxy_busy_buffers_size  256k;
                proxy_headers_hash_max_size 512;
                proxy_headers_hash_bucket_size 128;
                tcp_nodelay on;
                '';
            };
        };
    };
# prosody
    services.prosody = {
        xmppComplianceSuite = false;
        enable = true ;
        virtualHosts."meetone" = {
                enabled = true;
                domain = "meetone.macabara.cz";
                ssl.key= "${config.security.acme.certs."meetone.macabara.cz".directory}/key.pem";
                ssl.cert= "${config.security.acme.certs."meetone.macabara.cz".directory}/cert.pem";
                extraConfig = ''
                authentication = "anonymous";
                '';
            };
            modules.websocket = true;
            modules.smacks = true;
            extraConfig = ''
            cross_domain_websocket = true;
            consider_websocket_secure = true;
            smacks_max_unacked_stanzas = 5;
            smacks_hibernation_time = 60;
            smacks_max_hibernated_sessions = 1;
            smacks_max_old_sessions = 1;
            '';
    };
    # jistsi videobridge
    services.jitsi-videobridge = {
    openFirewall = true ;
    } ;

    # jitsi
    services.jitsi-meet = {
        enable = true;
        hostName = "meetone.macabara.cz";
        nginx.enable = true;
        prosody.enable = true;
        config = {
        websocket = wss://meetone.macabara.cz/xmpp-websocket;
        };
    };
# FW
networking.firewall.allowedTCPPorts = [ 80 443 5280 5281] ;
}
