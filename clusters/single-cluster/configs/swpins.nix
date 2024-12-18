{ config, ... }:
let
  nixpkgsBranch = branch: {
    type = "git-rev";
    git-rev = {
      url = "https://github.com/NixOS/nixpkgs";
      update.ref = "refs/heads/${branch}";
    };
  };
 novmarBranch = branch: {
  type = "git-rev";
  git-rev = {
    url = "https://github.com/novmar/nixpkgs";
    update.ref = "refs/heads/${branch}";
    };
  };
  vpsadminosBranch = branch: {
    type = "git-rev";
    git-rev = {
      url = "https://github.com/vpsfreecz/vpsadminos";
      update.ref = "refs/heads/${branch}";
    };
  };
in {
  confctl.swpins.channels = {
    nixos-unstable = { nixpkgs = nixpkgsBranch "nixos-unstable"; };
    nixos-stable = { nixpkgs = nixpkgsBranch "nixos-21.11"; };
    vpsadminos-prod = { vpsadminos = vpsadminosBranch "prod-22.01"; };
    vpsadminos-staging = { vpsadminos = vpsadminosBranch "staging"; };
#    novmar-meet = { nixpkgs = novmarBranch "meet-new"; };
    novmar-meet = { nixpkgs = novmarBranch "meet-actual"; };
  };
}
