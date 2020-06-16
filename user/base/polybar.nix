{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.gerhardt.polybar;

  eitherStrBoolIntList = with types;
    either str (either bool (either int (listOf str)));

  subConfigType = types.attrsOf eitherStrBoolIntList;
  primaryConfigType =  types.attrsOf subConfigType;

in {

  options = {
    gerhardt.polybar = {
      enable = mkEnableOption "Polybar";
      monitors = mkOption {
        default = [ ];
        type = with types; listOf str;
        description = ''
          The displays to place bars on. If unspecified polybar will place the primary bar on what it thinks is default.
        '';
      };
      primaryBarConfig = mkOption {
        default = { };
        type = subConfigType;
        description = ''
          Extra config for the primary bar.
        '';
      };
      secondaryBarConfig = mkOption {
        default = { };
        type = subConfigType;
        description = ''
          Extra config for the secondary bar.
        '';
      };
      extraConfig = mkOption {
        default = { };
        type = primaryConfigType;
        description = ''
          Extra config.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.polybar.Install.WantedBy = lib.mkForce [ ];
    xsession.windowManager.i3.config.startup = [{
      command = "systemctl --user start polybar";
      always = false;
      notification = true;
    }];

    services.polybar = {
      enable = true;
      package = pkgs.polybar.override { i3Support = true; };

      script = ''
        poly=`type -P polybar`
        ${pkgs.procps}/bin/pkill -u $UID -f $poly
        while ${pkgs.procps}/bin/pgrep -u $UID -f $poly >/dev/null; do
          ${pkgs.coreutils-full}/bin/sleep 1
        done
        polybar primary &
        ${concatImapStringsSep "\n" (i: value: "polybar ${toString i} &")
        (drop 1 cfg.monitors)}
      '';
      config = foldr (a: b: a // b) { } (imap1 (i: value: {
        "bar/${toString i}" = {
          #recursive inherit doesn't work :(
          "inherit" = "bar/base";
          "tray-position" = "none";
          "monitor" = "\${env:MONITOR:${value}}";
        } // cfg.secondaryBarConfig;
      }) (drop 1 cfg.monitors)) // {
        "colors" = {
          "background" = "#222";
          "background-alt" = "#444";
          "foreground" = "#dfdfdf";
          "foreground-alt" = "#555";
          "primary" = "#ffb52a";
          "secondary" = "#e60053";
          "alert" = "#bd2c40";
        };
        "bar/base" = {
          "width" = "100%";
          "height" = 27;
          "fixed-center" = false;
          "background" = "\${colors.background}";
          "foreground" = "\${colors.foreground}";
          "line-size" = 3;
          "line-color" = "#f00";
          "padding-left" = 0;
          "padding-right" = 2;
          "module-margin-left" = 1;
          "module-margin-right" = 2;
          "font-0" = "DejaVu Sans:pixelsize=10;1";
          "font-1" = "Siji:pixelsize=10;1";
          "font-2" = "Font Awesome 5 Free Regular:pixelsize=13";
          "font-3" = "Font Awesome 5 Free Solid:pixelsize=13";
          "font-4" = "Unifont:fontformat=truetype:size=8:antialias=false;0";
          "font-5" = "Fixed:pixelsize=10;1";

          "modules-left" = "i3";
          "modules-right" = "date";
          # "modules-right" = "music date";
          "tray-padding" = "2RR";
        };

        "bar/primary" = {
          "inherit" = "bar/base";
          # "monitor" = "\${env:MONITOR:DP-1}";
          "monitor" = mkIf (length cfg.monitors >= 1)
            "\${env:MONITOR:${head cfg.monitors}}";
          "tray-position" = "right";
        } // cfg.primaryBarConfig;

        "module/i3" = {
          "type" = "internal/i3";
          "format" = "<label-state> <label-mode>";
          "index-sort" = true;
          "wrapping-scroll" = false;

          "pin-workspaces" = true;

          "label-mode-padding" = 2;
          "label-mode-foreground" = "#000";
          "label-mode-background" = "\${colors.primary}";

          "label-focused" = "%name%";
          "label-focused-background" = "\${colors.background-alt}";
          "label-focused-underline" = "\${colors.primary}";
          "label-focused-padding" = 2;

          "label-unfocused" = "%name%";
          "label-unfocused-padding" = 2;

          "label-visible" = "%name%";
          "label-visible-background" = "\${self.label-focused-background}";
          "label-visible-underline" = "\${self.label-focused-underline}";
          "label-visible-padding" = "\${self.label-focused-padding}";

          "label-urgent" = "%name%";
          "label-urgent-background" = "\${colors.alert}";
          "label-urgent-padding" = 2;
        };

        "module/date" = {
          "type" = "internal/date";
          "interval" = 1;
          "date" = ''"%A %Y-%m-%d"'';
          "time" = ''"%l:%M:%S %p"'';
          "format-prefix" = "";
          "format-prefix-foreground" = "\${colors.foreground-alt}";
          "format-underline" = "#0a6cf5";
          "label" = "%date% %time%";
        };

        "settings" = { "screenchange-reload" = true; };
      } // cfg.extraConfig;
    };
  };
}
