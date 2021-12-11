{ config, ... }:
{
  cluster."meet-vpsfree" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-master" ];
    host = {
        target = "37.205.14.113";
    };
        tags = [ "meet-mvb" ] ;
  };
}
