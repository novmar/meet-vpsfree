{ config, ... }:
{
  cluster."jvb7" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.214";
      };
        tags = [ "meet-mvb" "meet-nixos" ] ;
  };
}