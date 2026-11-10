# Jitsi master (prosody + jicofo + web), videobridges connect from jvb.nix, e.g.
#   imports = [ (import ../../environments/meet.nix {
#     domain = "meet.vpsfree.cz"; assetsDomain = "meet-nixos.vpsfree.cz"; jvbTag = "meet-jvb"; }) ];
# jvbTag: confctl tag of the videobridges allowed to reach XMPP (5222)
{ domain, assetsDomain, jvbTag }:
{ config, pkgs, lib, ... }:
let
  images = "/data/nginx/images";

  # Fails the build when upstream CSS changes, so the branding never silently disappears
  allCss = pkgs.runCommand "jitsi-meet-all.css" { } ''
    substitute ${pkgs.jitsi-meet}/css/all.css $out \
      --replace-fail 'url(../images/welcome-background.png)' 'url(/image/server.jpg)' \
      --replace-fail 'width:71px;height:32px' 'width:140px;height:70px'
  '';

  jvbIps = lib.mapAttrsToList (_: m: m.host.target)
    (lib.filterAttrs (_: m: lib.elem jvbTag m.tags) config.cluster);

  acmeDir = config.security.acme.certs.${domain}.directory;
in
{
  imports = [ ./base.nix ];

  # jitsi-meet inherits libolm's knownVulnerabilities (deprecated E2EE library)
  nixpkgs.config.allowInsecurePredicate = pkg: lib.getName pkg == "jitsi-meet";

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  # XMPP c2s only for the videobridges, web clients go through nginx /xmpp-websocket
  networking.firewall.extraCommands = lib.concatMapStrings (ip: ''
    iptables -A nixos-fw -p tcp -s ${ip} --dport 5222 -j nixos-fw-accept
  '') jvbIps + ''
    iptables -A nixos-fw -p tcp -s 172.16.4.0/24 --dport 9888 -j nixos-fw-accept
  '';

  # jicofo's REST port (8888, localhost) also serves conference-request and move-endpoints,
  # so only its Prometheus /metrics is exposed, on 9888 for vpsFree monitoring
  services.nginx.virtualHosts."jicofo-metrics" = {
    listen = [ { addr = "0.0.0.0"; port = 9888; } ];
    locations."= /metrics".proxyPass = "http://127.0.0.1:8888/metrics";
    locations."/".return = "404";
  };

  # "*syslog" logs every level incl. debug (~150k lines/hour)
  services.prosody.log = ''{ info = "*syslog" }'';

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "acme@marnov.cz";

  # Trusted cert for the XMPP domain auth.<domain> (DNS: auth.<domain> CNAME <domain>),
  # so videobridges verify prosody. The name is added to the ACME cert via serverAliases below.
  security.acme.certs.${domain}.reloadServices = [ "prosody.service" ];
  users.users.prosody.extraGroups = [ config.security.acme.certs.${domain}.group ];
  services.prosody.virtualHosts."auth.${domain}".ssl = lib.mkForce {
    cert = "${acmeDir}/fullchain.pem";
    key = "${acmeDir}/key.pem";
  };

  services.nginx = {
    eventsConfig = "worker_connections 2048;";
    recommendedProxySettings = true;

    virtualHosts.${domain} = {
      serverAliases = [ "auth.${domain}" ]; # ACME SAN for prosody, see above
      locations = {
        "^~ /image/".root = images;
        "= /css/all.css".alias = allCss;
        "^~ /xmpp-websocket".extraConfig = "proxy_read_timeout 900s;";
      };
    };

    # Old branding host, kept for external links to the images
    virtualHosts.${assetsDomain} = {
      enableACME = true;
      forceSSL = true;
      locations."^~ /image/".root = images;
    };
  };

  services.jitsi-meet = {
    enable = true;
    hostName = domain;
    prosody.allowners_muc = true; # anyone can kick ghost participants
    videobridge.enable = false;
    videobridge.passwordFile = "/secrets/jitsi-meet/videobridge-secret";

    interfaceConfig = {
      APP_NAME = "Meet.vpsFree.cz";
      PROVIDER_NAME = "vpsFree.cz";
      DEFAULT_BACKGROUND = "#474747";
      JITSI_WATERMARK_LINK = "https://kb.vpsfree.cz/navody/meet";
      DEFAULT_WELCOME_PAGE_LOGO_URL = "/image/watermark-vpsf.png";
      DISPLAY_WELCOME_PAGE_CONTENT = true;
      LANG_DETECTION = false;
    };

    config = {
      defaultLanguage = "cs";
      defaultLogoUrl = "/image/watermark-vpsf.png";
      p2p.enabled = false;
      # "Shared document" button, needs a running Etherpad instance
      # etherpad_base = "https://pad.vpsfree.cz/p/";
    };
  };
}
