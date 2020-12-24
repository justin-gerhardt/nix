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

  fonts.fontconfig.enable = lib.mkForce true;

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
    #fonts
    source-code-pro
    font-awesome
    unifont
    siji

    #dbus debug
    bustle
    dfeet

    gnome3.gnome-screenshot
    pulsemixer
    spotify
    google-chrome
    gparted
    gitkraken
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
   
    (callPackage ./vscode.nix { })
    (callPackage ./zfsbackup { pkgs = lockedPkgs.newPkgs; })

  ];

}
