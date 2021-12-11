{ config, ... }:
{
  cluster."jvb8" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.219";
      };
        tags = [ "meet-mvb" ] ;
  };
}