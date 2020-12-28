{ config, pkgs, lib, ... }:
let package = (pkgs.callPackage ./package.nix { });
in {
  systemd.services.cleanup-backup = {

    description = "cleanup backups";
    after = [ "zfs-import.target" ];
    requires = [ "zfs-import.target" ];
    environment = { "TZ" = "UTC"; };
    serviceConfig = {
      "Type" = "oneshot";
      "ExecStart" = "${package}/cleanup.sh";
    };
  };

  systemd.timers.cleanup-backup = {
    description = "Run backup cleanup every hour";
    requires = [ "cleanup-backup.service" ];
    timerConfig = {
      OnCalendar = "*:3";
      Persistent = "true";
    };
    wantedBy = [ "timers.target" ];
  };

}

