{ config, ... }:
{
  imports = [ (import ../../environments/jvb.nix "meet.vpsfree.cz") ];
  networking.hostName = "jvb6";
  system.stateVersion = "24.11";
}
