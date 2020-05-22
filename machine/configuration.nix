{ config, pkgs, lib, ... }:
let
private = import ../private;
in
{
  imports = [ /etc/nixos/hardware-configuration.nix ../justin-home.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelParams = [ "nouveau.noaccel=1" ];
    initrd.supportedFilesystems = [ "zfs" ];
    kernel.sysctl."kernel.sysrq" = 1;
    supportedFilesystems = [ "zfs" ];
    zfs = {
      enableUnstable = true;
      requestEncryptionCredentials = true;
    };
  };

  networking.firewall.enable = false;

  nix.trustedUsers = [ "root" "justin" ];

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
  security.sudo.wheelNeedsPassword = false;
  time.timeZone = "America/Toronto";

  hardware.pulseaudio = {
    enable = true;
    extraConfig = ''
      load-module module-suspend-on-idle timeout=1
    '';
    # Only the full build has Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;
  };

  hardware.bluetooth.enable = true;
  systemd.services.nixos-upgrade.script =
    lib.mkOrder 100 "nix-channel --update";

  system.autoUpgrade.enable = true;

  services = {
    xserver = {
      enable = true;
      startDbusSession = false;
      # videoDrivers = [ "nvidia" ];
      displayManager.lightdm = {
        enable = true;
        autoLogin = {
          enable = true;
          user = "justin";
        };
      };
      #displayManager.startx.enable = true;

      desktopManager = {

        # To make home-manager's i3 available in system X session
        # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
        session = [{
          name = "home-manager";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
        }];
      };

      xrandrHeads = [ "DP-1" "DVI-D-1" ];
    };
    mingetty.autologinUser = "justin";
  };

  users = {
    mutableUsers = false;
    users.justin = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "wireshark" ];
      shell = pkgs.fish;
    };
    users.docker-media = {
      uid = 973;
      group = "docker-media";
    };
    groups.docker-media = { gid = 973; };
  };

  users.users.root.hashedPassword = private.userPasswordHashes.root;
  users.users.justin.hashedPassword = private.userPasswordHashes.justin;
  
  fonts.fonts = with pkgs; [ source-code-pro font-awesome unifont siji ];
  services.dbus.socketActivated = true;

  services.dbus.packages = [ pkgs.gnome3.gnome-terminal ];
  systemd.packages = [ pkgs.gnome3.gnome-terminal ];

  # programs.dconf.enable = true;
  i18n.defaultLocale = "en_CA.UTF-8";
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

