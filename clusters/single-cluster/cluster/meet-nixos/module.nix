{ config, ... }:
{
  cluster."meet-nixos" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.113";
    };
        tags = [ "meet-nixos" "meet-master" ] ;
  };
}
