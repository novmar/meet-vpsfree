{ config, ... }:
{
  cluster."master0" = {
    spin = "nixos";
   swpins.channels = [ "novmar-meet" "vpsadminos-master" ];
        host = {
#        target = "37.205.14.30";
        target = "37.205.14.16";
  };
  };
}
