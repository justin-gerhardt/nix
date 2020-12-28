{ config, pkgs, lib, ... }:
let package = (pkgs.callPackage ./package.nix { });
in {
  systemd.services.backup = {

    description = "Backup home folder";
    after = [ "zfs-import.target" ];
    requires = [ "zfs-import.target" ];
    environment = { "TZ" = "UTC"; };
    serviceConfig = {
      "Type" = "oneshot";
      "ExecStart" = "${package}/backup.sh";
    };
  };

  systemd.timers.backup = {
    description = "Run backup every 5 minutes";
    requires = [ "backup.service" ];
    timerConfig = {
      OnCalendar = "*:0/5";
      Persistent = "true";
    };
    wantedBy = [ "timers.target" ];
  };

}

