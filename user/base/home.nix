{ config, pkgs, lib, ... }:
let lockedPkgs = (import ../../machine/base/lockedpkgs.nix { inherit pkgs; });
in {
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  imports = [ ./fish.nix ];

  fonts.fontconfig.enable = lib.mkForce true;

  home.packages = with pkgs; [
    #fonts
    source-code-pro
    font-awesome
    unifont
    siji

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
    mbuffer
    gitkraken

    #dev tools
    nodejs
    pipenv
    python38
    gdb
    lldb
    gnumake
    (php74.withExtensions ({ enabled, all }:
      enabled
      ++ [ (callPackage ./xdebug.nix { }) (callPackage ./php-dbus.nix { }) ]))
    php74Packages.composer
    cargo
    rustfmt

    (callPackage ./playlist-downloader.nix { pkgs = lockedPkgs.newPkgs; })
    (callPackage ./spotify-scaler.nix { pkgs = lockedPkgs.newPkgs; })
    (callPackage ./vscode.nix { })

  ];

}
