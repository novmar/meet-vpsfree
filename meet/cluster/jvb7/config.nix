{ config, ... }:
{
  imports = [ (import ../../environments/jvb.nix "meet.vpsfree.cz") ];
  networking.hostName = "jvb7";
  system.stateVersion = "24.11";
}
