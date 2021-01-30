{ pkgs, overlays ? [], ... }: {
  # used for patched software the can update upstream
  modifiedPkgs = (import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    # nixos-unstable-small as of Sun 10 Jan 2021 01:54:00 AM EST
    rev = "97028f053c08fea03a64da70d6ae95199d1c7983";
    sha256 = "1g5pb9yv9znvy1fpp2v52785nlfnchwfzi6fjdz4z1wd1jpanraf";
  }) { config.allowUnfree = true; inherit overlays; });
  # used for my custom builds that won't update upstream
  newPkgs = (import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    # nixos-unstable-small as of Sun 10 Jan 2021 01:54:00 AM EST
    rev = "97028f053c08fea03a64da70d6ae95199d1c7983";
    sha256 = "1g5pb9yv9znvy1fpp2v52785nlfnchwfzi6fjdz4z1wd1jpanraf";
  }) { config.allowUnfree = true; inherit overlays;});
}
