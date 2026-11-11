{ config, ... }:
{
  imports = [
    (import ../../environments/jvb.nix "meet.vpsfree.cz")
    (import ../../environments/turn.nix { domain = "turn.meet.vpsfree.cz"; jvbTag = "meet-jvb"; })
  ];
  networking.hostName = "jvb1";
  system.stateVersion = "24.11";
}
