{ config, ... }:
{
  cluster."jvb2" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-master" ];
    host = {
        target = "37.205.14.150";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}