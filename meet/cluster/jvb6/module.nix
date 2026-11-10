{ config, ... }:
{
  cluster."jvb6" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.207";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
