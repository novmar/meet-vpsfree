# Jitsi master (prosody + jicofo + web), videobridges connect from jvb.nix, e.g.
#   imports = [ (import ../../environments/meet.nix { domain = "meet.vpsfree.cz"; assetsDomain = "meet-nixos.vpsfree.cz"; }) ];
{ domain, assetsDomain }:
{ config, pkgs, lib, ... }:
let
  images = "/data/nginx/images";

  # Fails the build when upstream CSS changes, so the branding never silently disappears
  allCss = pkgs.runCommand "jitsi-meet-all.css" { } ''
    substitute ${pkgs.jitsi-meet}/css/all.css $out \
      --replace-fail 'url(../images/welcome-background.png)' 'url(/image/server.jpg)' \
      --replace-fail 'width:71px;height:32px' 'width:140px;height:70px'
  '';
in
{
  imports = [ ./base.nix ];

  # jitsi-meet inherits libolm's knownVulnerabilities (deprecated E2EE library)
  nixpkgs.config.allowInsecurePredicate = pkg: lib.getName pkg == "jitsi-meet";

  networking.firewall.allowedTCPPorts = [
    80
    443
    5222 # XMPP c2s for the videobridges
  ];

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "acme@marnov.cz";

  services.nginx = {
    eventsConfig = "worker_connections 2048;";
    recommendedProxySettings = true;

    virtualHosts.${domain}.locations = {
      "^~ /image/".root = images;
      "= /css/all.css".alias = allCss;
      "^~ /xmpp-websocket".extraConfig = "proxy_read_timeout 900s;";
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
