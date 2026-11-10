{ config, ... }:
{
  cluster."jvb8" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.219";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
