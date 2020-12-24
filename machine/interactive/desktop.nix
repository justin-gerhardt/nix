{ config, pkgs, lib, ... }:

{
  imports = [ ../../user/interactive/desktop ./base ];

  networking = {
    hostName = "gerhardt-desktop";
    hostId = "abcdef01";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;

  };

  hardware.opengl.enable = true;
  environment.variables.VK_ICD_FILENAMES =
    "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd pkgs.amdvlk ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];

  services.xserver.xrandrHeads = [ "DP-1" "HDMI-1" ];

  # systemd.services.zfs-import-mediaPool.serviceConfig.RequiresMountsFor =
  #   /root/zfs/mediakey;

  users = {
    users.docker-media = {
      uid = 973;
      group = "docker-media";
    };
    groups.docker-media = { gid = 973; };
  };

  # steam
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

}

