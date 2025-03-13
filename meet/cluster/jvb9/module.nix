{ config, ... }:
{
  cluster."jvb9" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.231";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}