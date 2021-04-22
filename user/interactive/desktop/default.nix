{ config, pkgs, lib, ... }:

{
  home-manager.users.justin.gerhardt.polybar = rec {
    monitors = [  "DisplayPort-1" "DisplayPort-0"  ];
    primaryBarConfig = { "modules-right" = "a battery date"; };
    secondaryBarConfig = primaryBarConfig;
  };

}

