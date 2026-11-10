{ config, ... }:
{
  cluster."jvb5" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.182";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
