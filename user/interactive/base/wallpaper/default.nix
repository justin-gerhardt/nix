{ config, pkgs, ... }:
let image = ./background.jpg;
in {

  systemd.user.services.wallpaper = {
    Unit = {
      Description = "Set desktop background using feh";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.feh}/bin/feh --bg-fill --no-fehbg ${image}";
      IOSchedulingClass = "idle";
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
