{ config, ... }:
{
  imports = [
    (import ../../environments/meet.nix {
      domain = "test-meet.vpsfree.cz";
      assetsDomain = "test-meet-nixos.vpsfree.cz";
      jvbTag = "test-meet";
    })
  ];
  networking.hostName = "test-meet";
  services.jitsi-meet.jibri.enable = true;
  system.stateVersion = "23.11";
}
