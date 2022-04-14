{ config, ... }:
{
  cluster."jvb2" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.150";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}