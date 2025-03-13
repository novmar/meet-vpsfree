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
              nixpkgs.config.permittedInsecurePackages = [
                "jitsi-meet-1.0.8043"
              ];
  users.users.root.openssh.authorizedKeys.keys = with confData.sshKeys; admins;
}
