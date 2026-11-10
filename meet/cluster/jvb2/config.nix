{ config, ... }:
{
  imports = [ (import ../../environments/jvb.nix "meet.vpsfree.cz") ];
  networking.hostName = "jvb2";
  system.stateVersion = "24.11";
}
