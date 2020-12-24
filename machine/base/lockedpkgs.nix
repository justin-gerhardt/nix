{ pkgs, ... }: {
  # used for patched software the can update upstream
  modifiedPkgs = (import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    # nixos-unstable-small as of Wed 23 Dec 2020 11:21:49 AM EST
    rev = "2ae527c50e049570dd25132f9325527aa2320e32";
    sha256 = "0rggj7d5j6mmn5l4p72pj0bdxcsid0wxyjqfivdhmfvlsmh8hadn";
  }) { config.allowUnfree = true; });
  # used for my custom builds that won't update upstream
  newPkgs = (import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    # nixos-unstable-small as of Wed 23 Dec 2020 11:21:49 AM EST
    rev = "2ae527c50e049570dd25132f9325527aa2320e32";
    sha256 = "0rggj7d5j6mmn5l4p72pj0bdxcsid0wxyjqfivdhmfvlsmh8hadn";
  }) { config.allowUnfree = true; });
}
