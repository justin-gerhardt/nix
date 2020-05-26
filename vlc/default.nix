{ config, pkgs, ... }:

{
  # resume.patch removes the requirements to be at least 5% from the end of a video to resume where you left off
  # default_config.patch adds support for loading overridable settings from vlcrc-default
  # qt-settings.patch is the same for the qt interface settings (note this overrides the qsettings interface partically in a fragile way)

  home.packages = [
    (pkgs.vlc.overrideAttrs (oldAttrs: rec {
      patches = (if oldAttrs ? patches then oldAttrs.patches else [ ]) ++ [
        ./resume.patch
        ./default_config.patch
        ./qt-settings.patch
        ./show-chapters.patch
      ];
    }))
  ];
  xdg.configFile."vlc/vlcrc-default".text = ''
    [qt] # Qt interface
    qt-continue=2
    qt-privacy-ask=0

    [core] # core program
    # Playback speed (float)
    rate=2.500000
  '';

  xdg.configFile."vlc/vlc-qt-interface-default.conf".text = ''
    [MainWindow]
    status-bar-visible=true
  '';
}
