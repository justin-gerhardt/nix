{ config, pkgs, lib, ... }: {
  home.packages = [ (pkgs.callPackage ./package.nix { }) ];
  xdg.configFile = {
    "fontconfig/conf.d/99-gerhardt-emoji.conf".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <match>
        <!-- If the requested font is serif -->
          <test qual="any" name="family">
            <string>serif</string>
          </test>
          <edit name="family" mode="prepend_first">
            <string>emoji</string>
          </edit>
        </match>

        <match target="pattern">
          <!-- If the requested font is sans-serif -->
          <test qual="any" name="family">
            <string>sans-serif</string>
          </test>
          <!-- Followed by EmojiOne Color -->
          <edit name="family" mode="prepend_first">
            <string>emoji</string>
          </edit>
        </match>
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
