{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation {
  name = "desktop-backup";
  src = ./source;

  installPhase = ''
    mkdir $out
    cp sanoid.conf "$out/"
    substitute cleanup.sh $out/cleanup.sh \
        --replace @sanoid@ "${pkgs.sanoid}/bin/sanoid" \
        --replace @configFolder@ "$out/"
    chmod +x $out/cleanup.sh
  '';
}
