{ config, ... }:
{
  cluster."jvb10" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.250";
      };
        tags = [ "meet-mvb" ] ;
  };
}