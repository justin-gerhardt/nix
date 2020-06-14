{ pkgs ? import <nixpkgs> { }, stdenv }:
with pkgs;
let private = (import ../../private).spotify-scaler;
in rustPlatform.buildRustPackage rec {
  pname = "spotify-scaler";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "justin-gerhardt";
    repo = pname;
    rev = "651f212f273e785d4335e2e97b9c76c37cb1d0a9";
    sha256 = "1qn8c4wwnibs91pnnay6i7rbjbndsglazw753qqjfskybwgqjqdf";
  };

  cargoSha256 = "0dhcz6ix24q1qqr30ywb2wnxpkbqwcjq2zm0c375f0y99067mp3k";
  verifyCargoDeps = true;
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl makeWrapper ];
  propagatedBuildInputs = [ ffmpeg ];
  postInstall = ''
    wrapProgram $out/bin/spotify-scaler --prefix PATH ":" ${stdenv.lib.makeBinPath [ ffmpeg ]} --set-default WEB_CLIENT_ID '${private.clientId}' --set-default WEB_CLIENT_SECRET '${private.clientSecret}' --set-default SPOTIFY_USERNAME '${private.username}' --set-default SPOTIFY_PASSWORD '${private.password}'
  '';

}
