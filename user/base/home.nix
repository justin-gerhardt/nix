{ config, pkgs, lib, ... }:
let
  lockedPkgs = (import ../../machine/base/lockedpkgs.nix { inherit pkgs; });
in {
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  imports = [ ./fish.nix ];

  home.packages = with pkgs; [
    youtube-dl
    mkvtoolnix
    iotop
    file
    jq
    docker-compose
    git
    ldns # provides drill
    bat
    dtrx
    usbutils # provides lsusb
    tio
    tmux
    nmap

    #dev tools
    nodejs
    pipenv
    python38
    gdb
    gcc
    lldb
    gnumake
    (php74.withExtensions ({ enabled, all }:
      enabled ++ [ all.xdebug (callPackage ./php-dbus.nix { }) ]))
    php74Packages.composer
    cargo

    (callPackage ./playlist-downloader.nix { pkgs = lockedPkgs.newPkgs; })
    (callPackage ./spotify-scaler.nix { pkgs = lockedPkgs.newPkgs; })
  ];

}
