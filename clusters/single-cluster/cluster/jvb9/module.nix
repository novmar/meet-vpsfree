{ config, ... }:
{
  cluster."jvb9" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.231";
      };
        tags = [ "meet-mvb" ] ;
  };
}