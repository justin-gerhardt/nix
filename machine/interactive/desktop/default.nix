{ config, pkgs, lib, ... }:

{
  imports = [ ../../../user/interactive/desktop ../base ./backup ];

  networking = {
    hostName = "gerhardt-desktop";
    hostId = "abcdef01";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp5s0.useDHCP = true;

  };

  hardware.opengl.enable = true;
  # environment.variables.VK_ICD_FILENAMES =
  #   "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";
  hardware.opengl.driSupport = true;
  # hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd pkgs.amdvlk ];
  hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_5_9;
  # boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];

  services.xserver.xrandrHeads = [ "DisplayPort-1" "DisplayPort-0" ];
  # services.xserver.xrandrHeads = [ "DP-2" "DP-1" ];

  # systemd.services.zfs-import-mediaPool.serviceConfig.RequiresMountsFor =
  #   /root/zfs/mediakey;

  users = {
    users.docker-media = {
      uid = 973;
      group = "docker-media";
      isSystemUser = true;
    };
    groups.docker-media = { gid = 973; };
  };

  virtualisation.docker.extraOptions =
    "-s devicemapper --storage-opt dm.basesize=500G --storage-opt dm.loopdatasize=400G";

  # steam
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  fileSystems."/media/mediaVolume" = {
    device = "192.168.0.200:/media/mediaVolume";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };

  virtualisation.virtualbox.host.enable = true;
}

