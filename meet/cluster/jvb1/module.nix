{ config, ... }:
{
  cluster."jvb1" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.138";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
