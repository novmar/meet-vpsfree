{ config, ... }:
{
  cluster."jvb3" = {
    spin = "nixos";
    swpins.channels = [ "nixos-stable" "vpsadminos-master" ];
    host = {
        target = "37.205.14.163";
      };
        tags = [ "meet-mvb" ] ;
  };
}