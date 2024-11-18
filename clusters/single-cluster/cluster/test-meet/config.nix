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

  networking.firewall.enable = false;
  services.prometheus.exporters.jitsi.enable = true;
  services.prometheus.exporters.node.enable  = true;
#  services.prometheus.exporters.node.enabledCollectors  = [ "systemd" ];
  security.acme.acceptTerms = true ;
  security.acme.email = "acme@marnov.cz";

    # nginx
    services.nginx.appendConfig = '' worker_processes 20; '';
 	services.nginx.eventsConfig = '' worker_connections 2048; '' ;
    services.nginx.recommendedProxySettings = true;
    services.nginx.virtualHosts."meet-nixos.vpsfree.cz" = {
        enableACME = true;
        forceSSL = true;

        locations."^~ /image/".root = "/data/nginx/images";
    };
    services.nginx.virtualHosts."meet.vpsfree.cz" = {
        locations = {
            "=/xmpp-websocket" = {
                proxyPass = "http://meet.vpsfree.cz:5280/xmpp-websocket";
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
        virtualHosts."meet" = {
                enabled = true;
                domain = "meet.vpsfree.cz";
                ssl.key= "${config.security.acme.certs."meet.vpsfree.cz".directory}/key.pem";
                ssl.cert= "${config.security.acme.certs."meet.vpsfree.cz".directory}/cert.pem";
                extraConfig = ''
                authentication = "anonymous"
                allow_anonymous_s2s = true
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
    # jitsi
    services.jitsi-meet = {
        enable = true;
        hostName = "meet.vpsfree.cz";

        nginx.enable = true;
        prosody.enable = true;
        prosody.allowners_muc = true;
        prosody.withOwnerAllowKickPatch = true;
        videobridge.enable = false;
        videobridge.passwordFile = "/secrets/jitsi-meet/videobridge-secret";
        interfaceConfig = {
                DEFAULT_BACKGROUND = "#474747";
                DISABLE_VIDEO_BACKGROUND = false;
                INITIAL_TOOLBAR_TIMEOUT = 20000;
                TOOLBAR_TIMEOUT = 4000;
                TOOLBAR_ALWAYS_VISIBLE = false;
                DEFAULT_REMOTE_DISPLAY_NAME = "Fellow Jitster";
                DEFAULT_LOCAL_DISPLAY_NAME = "me";
                SHOW_JITSI_WATERMARK = true;
                JITSI_WATERMARK_LINK = "https://kb.vpsfree.cz/navody/meet";
                DEFAULT_LOGO_URL = "https://meet-nixos.vpsfree.cz/image/watermark-vpsf.png";
                DEFAULT_WELCOME_PAGE_LOGO_URL = "https://meet-nixos.vpsfree.cz/image/watermark-vpsf.png";

                SHOW_WATERMARK_FOR_GUESTS = true;
                SHOW_BRAND_WATERMARK = false;
                BRAND_WATERMARK_LINK = "";
                SHOW_POWERED_BY = false;
                SHOW_DEEP_LINKING_IMAGE = false;
                GENERATE_ROOMNAMES_ON_WELCOME_PAGE = true;
                DISPLAY_WELCOME_PAGE_CONTENT = true;
                DISPLAY_WELCOME_PAGE_TOOLBAR_ADDITIONAL_CONTENT = false;
                APP_NAME = "Meet.vpsFree.cz";
                NATIVE_APP_NAME = "Jitsi Meet";
                PROVIDER_NAME = "vpsFree.cz";
                LANG_DETECTION = false;
                INVITATION_POWERED_BY = true;
                TOOLBAR_BUTTONS =  [
        "microphone" "camera" "closedcaptions" "desktop" "fullscreen"
        "fodeviceselection" "hangup" "profile" "info" "chat"
        "livestreaming" "etherpad" "sharedvideo" "settings" "raisehand"
        "videoquality" "filmstrip" "invite" "feedback" "stats" "shortcuts"
        "tileview" "videobackgroundblur" "download" "help"  ];
                SETTINGS_SECTIONS = [ "devices" "language" "moderator" "profile" "calendar" ];
                VIDEO_LAYOUT_FIT = "both";
                filmStripOnly = false;
                CLOSE_PAGE_GUEST_HINT = false;
                RANDOM_AVATAR_URL_PREFIX = false;
                RANDOM_AVATAR_URL_SUFFIX = false;
                FILM_STRIP_MAX_HEIGHT = 120;
                ENABLE_FEEDBACK_ANIMATION = false;
                DISABLE_FOCUS_INDICATOR = false;
                DISABLE_DOMINANT_SPEAKER_INDICATOR = false;
                DISABLE_TRANSCRIPTION_SUBTITLES = false;

                DISABLE_RINGING = false;
                AUDIO_LEVEL_PRIMARY_COLOR = "rgba(255,255,255,0.4)";
                AUDIO_LEVEL_SECONDARY_COLOR = "rgba(255,255,255,0.2)";
                POLICY_LOGO = null;
#                LOCAL_THUMBNAIL_RATIO = "16 / 9";
                REMOTE_THUMBNAIL_RATIO = 1;
                LIVE_STREAMING_HELP_LINK = "https://jitsi.org/live";
                MOBILE_APP_PROMO = true;
            premeetingBackground = "url(https://meet-nixos.vpsfree.cz/image/server.jpg)";
            welcomePageHeaderBackground = "url(https://meet-nixos.vpsfree.cz/image/server.jpg)";

        };

        config = {
            premeetingBackground = "url(https://meet-nixos.vpsfree.cz/image/server.jpg)";
            welcomePageHeaderBackground = "url(https://meet-nixos.vpsfree.cz/image/server.jpg)";
            websocket = "wss://meet.vpsfree.cz/xmpp-websocket";
            openBridgeChannel = "websocket";
            defaultLanguage = "cs";
            etherpad_base = "https://pad.vpsfree.cz/p/";
            p2p = {
               enabled = false;
                };
            e2eping = {
            pingInterval = 1000;
            analyticsInterval = 5000;
                    };
            };
    };
# FW
networking.firewall.allowedTCPPorts = [ 80 443 5280 5281] ;
}
