{ config, ... }:
{
  cluster."jvb6" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.207";
      };
        tags = [ "meet-mvb" ] ;
  };
}