{ pkgs ? import <nixpkgs> { } }:

pkgs.buildGoPackage rec {
  pname = "zfsbackup";
  version = "unstable-2020-05-25";
  rev = "7793275d92bade8b3d088b990b4c01cf0b98869c";

  goPackagePath = "github.com/someone1/zfsbackup-go";

  src = pkgs.fetchFromGitHub {
    owner = "someone1";
    repo = "zfsbackup-go";
    inherit rev;
    sha256 = "0yalsfvzmcnc8yfzm3r5dikqrp57spwa16l7gbzvgqqcz4vlnw3n";
  };

  goDeps = ./deps.nix;
}
