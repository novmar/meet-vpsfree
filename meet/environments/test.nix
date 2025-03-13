{ config, pkgs, confData, ... }:
{
  time.timeZone = "Europe/Prague";
#networking.firewall.enable = false;
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    screen
    htop
    mc
  ];

  users.users.root.openssh.authorizedKeys.keys = with confData.sshKeys; admins;

#networking.extraHosts =
#  ''
#    37.205.13.90 test-meet.vpsfree.cz
#    37.205.13.90 test-meet-nixos.vpsfree.cz
#    37.205.14.250 test-jvb01.vpsfree.cz
#  '';
              nixpkgs.config.permittedInsecurePackages = [
                "jitsi-meet-1.0.8043"
              ];
}
