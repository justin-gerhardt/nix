{ pkgs ? import <nixpkgs> { } }:

with pkgs.python3Packages;

buildPythonPackage rec {
  pname = "PlaylistDownloader";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "justin-gerhardt";
    repo = pname;
    rev = "ca2445ca7d3ff285efe77463fee41e3667d29be6";
    sha256 = "008bgf27sq6j7x1zmnps5iy66vwd0x044g3kic9vdid2ry7qakwz";
  };

  propagatedBuildInputs =
    [regex pkgs.ffmpeg pkgs.mkvtoolnix pkgs.youtube-dl ];

  # No tests
  doCheck = false;
}
