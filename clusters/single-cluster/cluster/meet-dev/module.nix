{ config, ... }:
{
  cluster."meet-dev" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
        host = {
        target = "37.205.14.113";
  };
  };
}
