{ config, ... }:
{
  cluster."jvb4" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.178";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
