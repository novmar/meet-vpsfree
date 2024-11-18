{ config, ... }:
{
  cluster."test-jvb01" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.14.250";
      };
        tags = [ "meet-jvb" "meet-nixos" "test-meet" ] ;
  };
}
