{ config, ... }:
{
  cluster."jvb7" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.214";
      };
        tags = [ "meet-mvb" ] ;
  };
}