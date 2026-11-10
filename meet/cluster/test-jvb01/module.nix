{ config, ... }:
{
  cluster."test-jvb01" = {
    spin = "nixos";
    swpins.channels = [ "nixos-unstable" "vpsadminos-staging" ];
    host.target = "37.205.14.250";
    tags = [ "test-meet" ];
  };
}
