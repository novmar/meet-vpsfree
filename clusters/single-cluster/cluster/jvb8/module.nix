{ config, ... }:
{
  cluster."jvb8" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.219";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}