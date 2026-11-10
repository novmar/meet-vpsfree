{ config, ... }:
{
  cluster."jvb7" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.214";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
