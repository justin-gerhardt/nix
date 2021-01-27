{ config, pkgs, lib, ... }:

{
  home-manager.users.justin.gerhardt.polybar = rec {
    monitors = [ "DP-1" "HDMI-1" ];
    primaryBarConfig = { "modules-right" = "a battery date"; };
    secondaryBarConfig = primaryBarConfig;
  };

}

