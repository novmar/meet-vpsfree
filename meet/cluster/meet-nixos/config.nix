{ config, ... }:
{
  imports = [
    (import ../../environments/meet.nix {
      domain = "meet.vpsfree.cz";
      assetsDomain = "meet-nixos.vpsfree.cz";
      jvbTag = "meet-jvb";
      turnDomain = "turn.meet.vpsfree.cz";
    })
  ];
  networking.hostName = "meet";
  system.stateVersion = "24.11";
}
