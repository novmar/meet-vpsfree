{ config, ... }:
{
  cluster."jvb7" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-master" ];
    host = {
        target = "37.205.14.214";
      };
        tags = [ "meet-mvb" ] ;
  };
}