{ config, ... }:
{
  cluster."jvb10" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-master" ];
    host = {
        target = "37.205.14.250";
      };
        tags = [ "meet-mvb" ] ;
  };
}