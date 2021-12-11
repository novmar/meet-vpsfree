{ config, ... }:
{
  cluster."jvb11" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-master" ];
    host = {
        target = "37.205.13.90";
      };
        tags = [ "meet-mvb" ] ;
  };
}