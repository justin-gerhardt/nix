{ pkgs, ... }: {
  # used for patched software the can update upstream
  modifiedPkgs = (import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    # nixos-unstable-small as of Wed 30 Sep 2020 02:35:55 PM EDT
    rev = "c68d982ac8dcaa31461df22f1b4de0b6f7920b05";
    sha256 = "0i9m1vvsj1a591019z0yj21wn109p2np7q3rfhadfxi882f6nhxs";
  }) { config.allowUnfree = true; });
  # used for my custom builds that won't update upstream
  newPkgs = (import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    # nixos-unstable-small as of Wed 30 Sep 2020 02:35:55 PM EDT
    rev = "c68d982ac8dcaa31461df22f1b4de0b6f7920b05";
    sha256 = "0i9m1vvsj1a591019z0yj21wn109p2np7q3rfhadfxi882f6nhxs";
  }) { config.allowUnfree = true; });
}
