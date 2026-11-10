{ config, ... }:
{
  cluster."jvb3" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.163";
    tags = [ "meet-jvb" "meet-nixos" ];
  };
}
