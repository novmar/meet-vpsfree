{ config, ... }:
{
  cluster."jvb6" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-master" ];
    host = {
        target = "37.205.14.207";
      };
        tags = [ "meet-mvb" ] ;
  };
}