{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let private = (import ../../private).spotify-scaler;
in rustPlatform.buildRustPackage rec {
  pname = "spotify-scaler";
  version = "0.1.1";

  src = pkgs.fetchFromGitHub {
    owner = "justin-gerhardt";
    repo = pname;
    rev = "86034ab3118a7912e8019d14415228d3b94bc08f";
    sha256 = "13zwxhm4jhx7mzrx9j88r0nkjc6s9gzph19bp05hakmxqds03kc2";
  };

  cargoSha256 = "0as47hg93p0l09x2cb2r402kpds54ix1nc1zbslr0s1yqb62dgnm";
  verifyCargoDeps = true;
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl makeWrapper ];
  propagatedBuildInputs = [ ffmpeg ];
  postInstall = ''
    wrapProgram $out/bin/spotify-scaler --prefix PATH ":" ${lib.makeBinPath [ ffmpeg ]} --set-default WEB_CLIENT_ID '${private.clientId}' --set-default WEB_CLIENT_SECRET '${private.clientSecret}' --set-default SPOTIFY_USERNAME '${private.username}' --set-default SPOTIFY_PASSWORD '${private.password}'
  '';

}
