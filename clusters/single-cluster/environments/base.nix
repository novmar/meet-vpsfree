{ config, pkgs, confData, ... }:
{
  time.timeZone = "Europe/Prague";

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    screen
  ];

  users.users.root.openssh.authorizedKeys.keys = with confData.sshKeys; admins;
}