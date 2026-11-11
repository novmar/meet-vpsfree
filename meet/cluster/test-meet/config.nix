{ config, ... }:
{
  imports = [
    (import ../../environments/meet.nix {
      domain = "test-meet.vpsfree.cz";
      assetsDomain = "test-meet-nixos.vpsfree.cz";
      jvbTag = "test-meet";
      turnDomain = "turn.test-meet.vpsfree.cz";
    })
  ];
  networking.hostName = "test-meet";
  services.jitsi-meet.jibri.enable = true;
  system.stateVersion = "23.11";
}
