{ config, ... }:
{
  cluster."jvb5" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.182";
      };
        tags = [ "meet-mvb" ] ;
  };
}