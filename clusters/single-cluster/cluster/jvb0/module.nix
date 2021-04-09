{ config, ... }:
{
  cluster."jvb0" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-master" ];
        host = {
        target = "37.205.14.170";
  };
  };
}