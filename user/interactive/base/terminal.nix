{ config, pkgs, ... }:

{
  dconf.enable = true;
  dconf.settings."org/gnome/terminal/legacy".theme-variant = "dark";
  home.packages = with pkgs; [ dconf gnome3.gnome-terminal ];
}
