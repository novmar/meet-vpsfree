{ config, ... }:
{
  cluster."jvb4" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.178";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}