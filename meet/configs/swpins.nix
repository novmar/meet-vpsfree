{ config, ... }:
let
  nixpkgsBranch = branch: {
    type = "git-rev";
    git-rev = {
      url = "https://github.com/NixOS/nixpkgs";
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
    vpsadminos-staging = { vpsadminos = vpsadminosBranch "staging"; };
  };
}
