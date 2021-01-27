{ config, pkgs, lib, ... }:
let
  lockedPkgs = (import ../../base/lockedpkgs.nix { inherit pkgs; });
in {
  imports = [ ../../../user/interactive/base ../../base ];

  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    zfs.requestEncryptionCredentials = true;
  };

  hardware.pulseaudio = {
    enable = true;
    package = (lockedPkgs.modifiedPkgs.callPackage ./pulseaudio { });
  };

  services = {
    xserver = {
      libinput.enable = true;

      enable = true;
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
  programs.ssh.startAgent = true;

  users.users.justin.extraGroups = [ "wireshark" "adbusers" ];
  fonts.fonts = with pkgs; [ source-code-pro font-awesome unifont siji ];

  services.dbus.packages = [ pkgs.gnome3.gnome-terminal ];
  systemd.packages = [ pkgs.gnome3.gnome-terminal ];

  # programs.dconf.enable = true;
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt; # (pkgs.callPackage ./wireshark { });
  };

}

