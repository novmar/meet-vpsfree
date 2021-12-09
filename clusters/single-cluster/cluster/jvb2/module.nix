{ config, ... }:
{
  cluster."jvb2" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.150";
      };
        tags = [ "meet-mvb" ] ;
  };
}