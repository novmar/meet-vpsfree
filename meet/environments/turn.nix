# TURN for clients that cannot reach the videobridges over UDP 10000, e.g.
#   imports = [ (import ../../environments/turn.nix { domain = "turn.meet.vpsfree.cz"; jvbTag = "meet-jvb"; }) ];
# Credentials come from prosody (external_services in meet.nix), signed with the shared
# secret in /secrets/turn/secret (root 0600, same content on the master, not in this repo).
# jvbTag: the relay may only reach these bridges (P2P is disabled), nothing else.
{ domain, jvbTag }:
{ config, lib, ... }:
let
  jvbIps = lib.mapAttrsToList (_: m: m.host.target)
    (lib.filterAttrs (_: m: lib.elem jvbTag m.tags) config.cluster);
  cert = config.security.acme.certs.${domain}.directory;
in
{
  services.coturn = {
    enable = true;
    realm = domain;
    use-auth-secret = true;
    static-auth-secret-file = "/run/credentials/coturn.service/turn-secret";
    listening-port = 3478;
    tls-listening-port = 443; # TURNS gets through firewalls that only allow HTTPS
    cert = "${cert}/fullchain.pem";
    pkey = "${cert}/key.pem";
    no-cli = true;
    no-tcp-relay = true; # bridges are reached over UDP
    extraConfig = ''
      syslog
      no-multicast-peers
      denied-peer-ip=0.0.0.0-255.255.255.255
      denied-peer-ip=::-ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
      ${lib.concatMapStrings (ip: "allowed-peer-ip=${ip}\n") jvbIps}
    '';
  };

  # Standalone HTTP-01 challenge, nothing else listens on 80 here
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@marnov.cz";
    certs.${domain} = {
      listenHTTP = ":80";
      group = "turnserver";
      reloadServices = [ "coturn.service" ];
    };
  };

  systemd.services.coturn.serviceConfig = {
    LoadCredential = [ "turn-secret:/secrets/turn/secret" ];
    # The module's PrivateUsers=true voids CAP_NET_BIND_SERVICE for the host netns:
    # binding 443 fails with EACCES
    PrivateUsers = lib.mkForce false;
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 3478 ];
    allowedUDPPorts = [ 3478 ];
    # Relay ports only receive traffic from the bridges (allowed-peer-ip above)
    extraCommands = lib.concatMapStrings (ip: ''
      iptables -A nixos-fw -p udp -s ${ip} --dport ${toString config.services.coturn.min-port}:${toString config.services.coturn.max-port} -j nixos-fw-accept
    '') jvbIps;
  };
}
