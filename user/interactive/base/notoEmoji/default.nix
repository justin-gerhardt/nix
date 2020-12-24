{ pkgs, ... }: {
  home.packages = [ (pkgs.callPackage ./package.nix { }) ];
  xdg.configFile = {
    "fontconfig/conf.d/99-gerhardt-emoji.conf".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <selectfont>
          <rejectfont>
            <pattern>
              <patelt name="family">
                <string>Noto Emoji</string>
              </patelt>
            </pattern>
          </rejectfont>
        </selectfont>
        <match target="font">
          <test name="family">
            <string>Noto Color Emoji</string>
          </test>
          <edit name="pixelsize" mode="assign">
            <times><name>pixelsize</name>, <double>1.4</double></times>
          </edit>
        </match>
      </fontconfig>
    '';
  };
}
