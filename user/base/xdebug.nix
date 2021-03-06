{ pkgs ? import <nixpkgs> { } }:
pkgs.php74.buildPecl rec {
  pname = "xdebug";

  version = "3.0.2";
  sha256 = "05sfgkw55ym7mg0b54l9x3i9598kf2bkp4z3sdl1hd31q3g4cv89";

  doCheck = true;
  checkTarget = "test";

  zendExtension = true;

    postInstall = ''
    cp $out/lib/php/extensions/xdebug.so $out/lib/php/extensions/php.so
  '';
}

