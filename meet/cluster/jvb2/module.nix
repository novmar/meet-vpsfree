{ config, ... }:
{
  cluster."jvb2" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.150";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
