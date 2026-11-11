{ config, ... }:
{
  imports = [
    (import ../../environments/jvb.nix "test-meet.vpsfree.cz")
    (import ../../environments/turn.nix { domain = "turn.test-meet.vpsfree.cz"; jvbTag = "test-meet"; })
  ];
  networking.hostName = "test-jvb01";
  system.stateVersion = "24.11";
}
