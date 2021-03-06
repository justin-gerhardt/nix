{ config, lib, pkgs, ... }:

let mod = "Mod4";
in {

  services.picom = {
    enable = true;
    backend = "glx";
    refreshRate = 60;
    vSync = true;
    extraOptions = ''
      glx-no-stencil = true;
      glx-copy-from-front = false;
      glx-use-copysubbuffermesa = false;
      glx-no-rebind-pixmap = false;
      dbe = true;
      unredir-if-possible = false;
      xrender-sync-fence = true;
    '';
  };
  xsession = {
    scriptPath = ".hm-xsession";
    enable = true;
    numlock.enable = true;
    pointerCursor.size = 24;
    pointerCursor.name = "Bibata_Classic";
    pointerCursor.package = pkgs.bibata-cursors;

    windowManager.i3 = {
      enable = true;
      config = {
        window.titlebar = false;
        modifier = mod;

        fonts = [ "DejaVu Sans Mono, FontAwesome 7" ];
        bars = [ ];
        modes = {
          resize = {
            "Left" = "resize shrink width 10 px or 10 ppt";
            "Down" = "resize grow height 10 px or 10 ppt";
            "Up" = "resize shrink height 10 px or 10 ppt";
            "Right" = "resize grow width 10 px or 10 ppt";
            "Escape" = "mode default";
            "Return" = "mode default";
            "${mod}+r" = "mode default";

          };
        };
        keybindings = {

          "${mod}+d" = "exec ${pkgs.j4-dmenu-desktop}/bin/j4-dmenu-desktop";
          "${mod}+Shift+q" = "kill";
          "${mod}+Shift+e" = "exit";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+Return" = "exec gnome-terminal";
          "${mod}+c" = "exec google-chrome-stable";
          "${mod}+l" = "exec dm-tool lock";
          "${mod}+v" = "exec bluetoothctl connect 4C:87:5D:A1:07:80";

          "XF86MonBrightnessUp" = "exec xbacklight -inc 10";
          "XF86MonBrightnessDown" = "exec xbacklight -dec 10";

          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioRaiseVolume" =
            "exec pactl set-sink-mute @DEFAULT_SINK@ false && pactl set-sink-volume @DEFAULT_SINK@ +3%";
          "XF86AudioLowerVolume" =
            "exec pactl set-sink-mute @DEFAULT_SINK@ false && pactl set-sink-volume @DEFAULT_SINK@ -3%";

          "XF86AudioStop" = "exec ${
              lib.makeBinPath [ pkgs.playerctl ]
            }/playerctl --player=spotify stop";
          "XF86AudioNext" = "exec ${
              lib.makeBinPath [ pkgs.playerctl ]
            }/playerctl --player=spotify next";
          "XF86AudioPrev" = "exec ${
              lib.makeBinPath [ pkgs.playerctl ]
            }/playerctl --player=spotify previous";
          "XF86AudioPlay" = "exec ${
              lib.makeBinPath [ pkgs.playerctl ]
            }/playerctl --player=spotify play-pause";

          "${mod}+Shift+r" = "restart";

          "${mod}+Left" = "move left";
          "${mod}+Right" = "move right";
          "${mod}+Up" = "move up";
          "${mod}+Down" = "move down";

          # these get sorted alphabetically and it seems i3 is taking the first one as the default
          # workspace, so don't include a workspace 0

          "${mod}+1" = "move container to workspace 1";
          "${mod}+2" = "move container to workspace 2";
          "${mod}+3" = "move container to workspace 3";
          "${mod}+4" = "move container to workspace 4";
          "${mod}+5" = "move container to workspace 5";
          "${mod}+6" = "move container to workspace 6";
          "${mod}+7" = "move container to workspace 7";
          "${mod}+8" = "move container to workspace 8";
          "${mod}+9" = "move container to workspace 9";

          "${mod}+Shift+1" = "workspace number 1";
          "${mod}+Shift+2" = "workspace number 2";
          "${mod}+Shift+3" = "workspace number 3";
          "${mod}+Shift+4" = "workspace number 4";
          "${mod}+Shift+5" = "workspace number 5";
          "${mod}+Shift+6" = "workspace number 6";
          "${mod}+Shift+7" = "workspace number 7";
          "${mod}+Shift+8" = "workspace number 8";
          "${mod}+Shift+9" = "workspace number 9";

          "${mod}+h" = "split h";
          "${mod}+g" = "split v";

          "${mod}+r" = "mode resize";

        };

      };
      extraConfig = ''
        default_border none
      '';
    };
  };

}
