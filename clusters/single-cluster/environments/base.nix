{ config, pkgs, confData, ... }:
{
  time.timeZone = "Europe/Prague";

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    screen
    htop
    mc
  ];

  users.users.root.openssh.authorizedKeys.keys = with confData.sshKeys; admins;
}
