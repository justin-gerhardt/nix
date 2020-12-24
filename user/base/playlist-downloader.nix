{ pkgs ? import <nixpkgs> { } }:

with pkgs.python3Packages;

buildPythonPackage rec {
  pname = "PlaylistDownloader";
  version = "0.1.1";

  src = pkgs.fetchFromGitHub {
    owner = "justin-gerhardt";
    repo = pname;
    rev = "e9d5ae849c440f9c6e569e5ede65996238428650";
    sha256 = "1kl67xw4mkk523i59ajlyv6pqddrpzpj8n0k6ybz8421knqr43cc";
  };

  propagatedBuildInputs = [ regex pkgs.ffmpeg pkgs.mkvtoolnix pkgs.youtube-dl ];

  # No tests
  doCheck = false;
}
