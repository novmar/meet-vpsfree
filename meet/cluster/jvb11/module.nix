{ config, ... }:
{
  cluster."jvb11" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.13.90";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
