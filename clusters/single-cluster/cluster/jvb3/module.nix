{ config, ... }:
{
  cluster."jvb3" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.163";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}