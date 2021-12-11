{ config, ... }:
{
  cluster."jvb1" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-master" ];
    host = {
        target = "37.205.14.138";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}