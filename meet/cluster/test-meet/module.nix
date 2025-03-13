{ config, ... }:
{
  cluster."test-meet" = {
    spin = "nixos";
    swpins.channels = [ "novmar-meet" "vpsadminos-staging" ];
    host = {
        target = "37.205.13.90";
      };
        tags = [ "test-meet"] ;
  };
}
