{ config, pkgs, lib, ... }:

{
  imports = [ <home-manager/nixos> ];
  home-manager.users.justin.gerhardt.polybar.monitors = [ "DP-2" "HDMI-1"];
}

