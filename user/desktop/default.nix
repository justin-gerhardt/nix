{ config, pkgs, lib, ... }:

{
  imports = [ <home-manager/nixos> ];
  home-manager.users.justin.gerhardt.polybar.monitors = [ "DP-1" "DVI-D-1"];
}
