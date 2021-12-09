{ config, ... }:
{
  cluster."jvb4" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.178";
      };
        tags = [ "meet-mvb" ] ;
  };
}