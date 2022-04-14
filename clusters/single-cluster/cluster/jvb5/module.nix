{ config, ... }:
{
  cluster."jvb5" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.182";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}