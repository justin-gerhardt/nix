{ config, pkgs, lib, ... }:

{
  imports = [ ../user/desktop ./base ];

  networking = {
    hostName = "gerhardt-desktop";
    hostId = "abcdef01";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;

  };

  services.xserver.xrandrHeads = [ "DP-1" "HDMI-1" ];

  systemd.services.zfs-import-mediaPool.serviceConfig.RequiresMountsFor =
    /root/zfs/mediakey;

  users = {
    users.docker-media = {
      uid = 973;
      group = "docker-media";
    };
    groups.docker-media = { gid = 973; };
  };
}

