{ config, pkgs, lib, ... }:
let
  private = import ../../private;
  lockedPkgs = (import ./lockedpkgs.nix {inherit pkgs;});
in {
  imports = [ /etc/nixos/hardware-configuration.nix ../../user/base ./jlink ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelParams = [ "nouveau.noaccel=1" ];
    initrd = {
      supportedFilesystems = [ "zfs" ];
      kernelModules = [ "amdgpu" ];
    };
    kernel.sysctl."kernel.sysrq" = 1;
    supportedFilesystems = [ "zfs" ];
    zfs = {
      enableUnstable = true;
      requestEncryptionCredentials = true;
    };
  };

  networking.firewall.enable = false;

  nix.trustedUsers = [ "root" "justin" ];

  nixpkgs.config.allowUnfree = true;

  security.sudo.wheelNeedsPassword = false;
  time.timeZone = "America/Toronto";

  hardware.pulseaudio = {
    enable = true;
    package = (lockedPkgs.modifiedPkgs.callPackage ./pulseaudio { });
  };

  hardware.bluetooth.enable = true;
  hardware.cpu.amd.updateMicrocode = true;
  systemd.services.nixos-upgrade.script =
    lib.mkOrder 100 "nix-channel --update";

  system.autoUpgrade.enable = true;

  services = {

    openssh = {
      enable = true;
      passwordAuthentication = false;
    };

    pcscd.enable = true;
    xserver = {
      libinput.enable = true;

      enable = true;
      startDbusSession = false;
      # videoDrivers = [ "nvidia" ];
      displayManager = {
        lightdm.enable = true;
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

    };
    mingetty.autologinUser = "justin";
  };

  programs.adb.enable = true;

  users = {
    mutableUsers = false;
    users.justin = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "wireshark" "adbusers" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDa2e6APkYYp8n4Pw20krw8ypsHtVs0T1sR6KfCxRw4+wX/ZPla+fXOSiN4prIASSmMGlkqgOED80SMKXQLqa7FjTtGUEwfpJO2SrJQJH68uGKOyBWna3aSIMRXmb0OOTmgCiZbh1+Xp5e5aWF0FSP136f3YaO1ApLqjuwc1lgmrKQQA0DRknW6git6Q+4GvbUbqeFFP+zHcQ1AMaqYBI3Nyut9PMKw4mIvol8DmDNpkunkA8nwI6Iec33gzxhOxFSRNYJhdp2ZfYndtMzjbE6vHpwQ7wHOZ8xlfQy2N7BGd3sZH2M6vGIh5yTfo4Y+26cgVOdGPdmtSYucx15D7p9hhbK8qXh+26GY8y53jIKT5ReFT6T8wt3lLOxJYNduc7+O0I+RWGOy0yZtySz0Gyvx2W3BsCOU34xMbJmHdvsNVXOvD/2vS0AtuqkYv9ox+dnXaIIhexKfoxYrdpMiTXHI557IDIUr4SUPjAMHHIfsFGYvn+IyvghvDYZE0RZgOAs= justin@gerhardt-laptop"];
    };
  };

  users.users.root.hashedPassword = private.userPasswordHashes.root;
  users.users.justin.hashedPassword = private.userPasswordHashes.justin;

  fonts.fonts = with pkgs; [ source-code-pro font-awesome unifont siji ];
  services.dbus.socketActivated = true;

  services.dbus.packages = [ pkgs.gnome3.gnome-terminal ];
  systemd.packages = [ pkgs.gnome3.gnome-terminal ];

  # programs.dconf.enable = true;
  i18n.defaultLocale = "en_CA.UTF-8";
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt; # (pkgs.callPackage ./wireshark { });
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

