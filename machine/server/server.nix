{ config, pkgs, lib, ... }:

{
  imports = [ ../base ./backup ];

  networking = {
    hostName = "gerhardt-server";
    hostId = "abcdef03";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp9s0.useDHCP = true;
    interfaces.enp3s0.useDHCP = true;
    interfaces.wlp7s0.useDHCP = true;

  };

  environment.systemPackages = [ pkgs.xorg.xauth ];
  services.openssh.forwardX11 = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];

  systemd.services.zfs-import-mediaPool.serviceConfig.RequiresMountsFor =
    /root/zfs/mediakey;

  users = {
    users.docker-media = {
      uid = 973;
      group = "docker-media";
      isSystemUser = true;
    };
    groups.docker-media = { gid = 973; };
  };

  boot.zfs.requestEncryptionCredentials = [ "mediaPool/encrypted" ];

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /media/mediaVolume         192.168.0.0/24(ro,no_subtree_check,mountpoint)
  '';
}

