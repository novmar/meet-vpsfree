{ config, ... }:
{
  imports = [
    (import ../../environments/meet.nix {
      domain = "meet.vpsfree.cz";
      assetsDomain = "meet-nixos.vpsfree.cz";
      jvbTag = "meet-jvb";
    })
  ];
  networking.hostName = "meet";
  system.stateVersion = "24.11";
}
