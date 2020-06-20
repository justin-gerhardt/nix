{ pkgs ? import <nixpkgs> { } }:
let inherit (pkgs) python3Packages;
in pkgs.stdenv.mkDerivation {
  pname = "CustomizedNotoEmoji";
  version = "1";

  src = pkgs.fetchFromGitHub {
    owner = "justin-gerhardt";
    repo = "CustomizedNotoEmoji";
    rev = "dbb760fc59b6eb092d88ac0c8e5e4f71c4d00cb1";
    sha256 = "1jhvm5sxifm50fj4i58f3jb5ckjwhsifvkrpjvi1sal72ly9zzq4";
  };

  buildInputs = [ pkgs.cairo ];
  nativeBuildInputs = with pkgs;
    [ pngquant optipng which cairo pkgconfig imagemagick zopfli ]
    ++ (with python3Packages; [ python fonttools nototools ]);

  postPatch = ''
    sed -i 's,^PNGQUANT :=.*,PNGQUANT := ${pkgs.pngquant}/bin/pngquant,' Makefile
    sed -i 's,MISSING_VENV = fail,,' Makefile
    patchShebangs flag_glyph_name.py
  '';

  enableParallelBuilding = true;

  installPhase = ''
    mkdir -p $out/share/fonts/noto2
    cp NotoColorEmoji.ttf fonts/NotoEmoji-Regular.ttf $out/share/fonts/noto2
  '';
}
