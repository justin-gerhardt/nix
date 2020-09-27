# https://nixos.wiki/wiki/Home_Manager

# Stuff on this file, and ./home/*.nix, should work across all of my computing
# devices. Presently these are: Thinkpad, Macbook and Pixel Slate.

{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  systemd.user.services.mpris-proxy = {
    Unit.Description = "Mpris proxy";
    Unit.After = [ "network.target" "sound.target" ];
    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    Install.WantedBy = [ "default.target" ];
  };

  fonts.fontconfig.enable = lib.mkForce true;

  imports = [
    ./i3.nix
    ./vlc
    ./fish.nix
    ./polybar.nix
    ./wallpaper
    ./kdeconnect.nix
    ./terminal.nix
    ./notoEmoji
    ./megasync.nix
  ];

  gerhardt.polybar.enable = true;

  home.packages = with pkgs; [
    #fonts
    source-code-pro
    font-awesome
    unifont
    siji

    #dbus debug
    # bustle
    dfeet

    gnome3.gnome-screenshot
    pulsemixer
    youtube-dl
    mkvtoolnix
    spotify
    google-chrome
    iotop
    gparted
    file
    gitkraken
    jq
    docker-compose
    git
    ldns # provides drill
    eagle
    yubikey-manager
    yubioath-desktop
    bat
    dtrx
    sqlitebrowser
    usbutils # provides lsusb
    android-studio
    gnome3.nautilus
    stm32cubemx
    tio

    burpsuite
    charles

    #dev tools
    nodejs
    pipenv
    python38
    cairo
    heroku
    gdb
    gcc
    lldb
    gnumake

    (callPackage ./playlist-downloader.nix { })
    (callPackage ./spotify-scaler.nix { })
    (callPackage ./vscode.nix { })
    (callPackage ./zfsbackup { })

  ];

}
