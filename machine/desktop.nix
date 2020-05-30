{ config, pkgs, lib, ... }:

{
  imports = [ ../user/desktop ./base.nix ];


  networking = {
    hostName = "gerhardt-desktop";
    hostId = "abcdef01";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp30s0.useDHCP = true;
    interfaces.enp42s0.useDHCP = true;
    interfaces.wlp39s0.useDHCP = true;

  };

  systemd.services.zfs-import-mediaPool.serviceConfig.RequiresMountsFor =
    /root/zfs/mediakey;

  users = {
    users.docker-media = {
      uid = 973;
      group = "docker-media";
    };
    groups.docker-media = { gid = 973; };
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
}

