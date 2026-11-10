# Videobridge connected to the given Jitsi master, e.g.
#   imports = [ (import ../../environments/jvb.nix "meet.vpsfree.cz") ];
domain:
{ config, ... }:
{
  imports = [ ./base.nix ];

  services.prometheus.exporters.jitsi.enable = true;

  services.jitsi-videobridge = {
    enable = true;
    openFirewall = true; # UDP 10000
    colibriRestApi = true; # localhost only, used by the jitsi exporter
    # Public IP sits directly on venet0, no NAT discovery through 3rd-party STUN
    nat.harvesterAddresses = [ ];
    config.videobridge.server-id = config.networking.hostName;
    xmppConfigs.${domain} = {
      domain = "auth.${domain}";
      hostName = domain;
      userName = "jvb";
      mucNickname = config.networking.hostName;
      # prosody serves auth.<domain> with a self-signed cert; once it has the ACME cert
      # (environments/meet.nix, needs DNS auth.<domain>) switch to false
      disableCertificateVerification = true;
      # disableCertificateVerification = false;
      passwordFile = "/secrets/jitsi-meet/videobridge-secret";
      mucJids = "jvbbrewery@internal.auth.${domain}";
    };
  };
}
