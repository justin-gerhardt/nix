{ config, pkgs, lib, ... }:
let
  lockedPkgs = (import ../../../machine/base/lockedpkgs.nix { inherit pkgs; });
in {

  systemd.user.services.mpris-proxy = {
    Unit.Description = "Mpris proxy";
    Unit.After = [ "network.target" "sound.target" ];
    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    Install.WantedBy = [ "default.target" ];
  };


  imports = [
    ./i3.nix
    ./polybar.nix
    ./wallpaper
    ./kicad.nix
    ./kdeconnect.nix
    ./terminal.nix
    (import ./notoEmoji { pkgs = lockedPkgs.newPkgs; })
    (import ./megasync.nix { pkgs = lockedPkgs.newPkgs; })
    (import ./vlc { pkgs = lockedPkgs.newPkgs; })
  ];

  gerhardt.polybar.enable = true;

  home.packages = with pkgs; [
     #dbus debug
    bustle
    dfeet

    gnome3.gnome-screenshot
    pulsemixer
    spotify
    google-chrome
    gparted
    eagle
    yubikey-manager
    yubioath-desktop
    sqlitebrowser
    android-studio
    gnome3.nautilus
    stm32cubemx
    anydesk
    steam
    jetbrains.phpstorm

    burpsuite
    charles

    #dev tools
    cairo
    heroku

    slack
    postman
   
    (callPackage ./zfsbackup { pkgs = lockedPkgs.newPkgs; })

  ];

}
