{ config, pkgs, lib, ... }:
{
  imports = [
        ../../environments/base.nix
        ../../environments/jvb.nix
        ./module.nix
        <vpsadminos/os/lib/nixos-container/vpsadminos.nix>

  ];
  networking.hostName = "jvb9";
  system.stateVersion = "24.11";
}