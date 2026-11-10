{ config, ... }:
{
  cluster."jvb9" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.231";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
