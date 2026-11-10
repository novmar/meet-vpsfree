{ config, ... }:
{
  imports = [ (import ../../environments/jvb.nix "test-meet.vpsfree.cz") ];
  networking.hostName = "test-jvb01";
  system.stateVersion = "24.11";
}
