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

  dconf.enable = true;

  fonts.fontconfig.enable = lib.mkForce true;

  imports =
    [ ./i3.nix ./vlc ./fish.nix ./polybar.nix ./wallpaper ./kdeconnect.nix ];

  home.packages = with pkgs; [
    #fonts
    gnome3.gnome-terminal

    source-code-pro
    font-awesome
    unifont
    siji
    gnome3.gnome-screenshot
    nodejs
    pipenv
    python38
    cairo
    gitkraken
    heroku
    postman
    jq
    pulsemixer
    youtube-dl
    spotify
    xorg.xwininfo
    pstree
    google-chrome
    gdb
    feh
    docker-compose
    ldns
    pciutils
    git

    # bundler
    gcc
    gnumake
    coreutils-full
    libffi
    ruby
    rake

    iotop
    gparted

    lldb
    gdb
    file

    (callPackage ./playlist-downloader.nix { })
    (callPackage ./vscode.nix { })
    python3Packages.sphinx
  ];

}
