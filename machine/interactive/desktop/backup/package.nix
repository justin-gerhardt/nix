{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation {
  name = "desktop-backup";
  src = ./source;

  installPhase = ''
    mkdir $out
    cp sanoid.conf "$out/"
    substitute backup.sh $out/backup.sh \
        --replace @sanoid@ "${pkgs.sanoid}/bin/sanoid" \
        --replace @syncoid@ "${pkgs.sanoid}/bin/syncoid" \
        --replace @sshkey@ "/home/justin/.ssh/justin.key" \
        --replace @configFolder@ "$out/"
    chmod +x $out/backup.sh
  '';
}
