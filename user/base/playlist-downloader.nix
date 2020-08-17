{ pkgs ? import <nixpkgs> { } }:

with pkgs.python3Packages;

buildPythonPackage rec {
  pname = "PlaylistDownloader";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "justin-gerhardt";
    repo = pname;
    rev = "5d98dae9ea1a829fcb90b4a57868ad1acd1469c9";
    sha256 = "00yhqz8f62c5m88qzshr46xkz7j3xmnwhkwgh19jkj39s6x3s9f7";
  };

  propagatedBuildInputs = [ regex pkgs.ffmpeg pkgs.mkvtoolnix pkgs.youtube-dl ];

  # No tests
  doCheck = false;
}
