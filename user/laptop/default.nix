{ config, pkgs, lib, ... }:

{
  home-manager.users.justin.gerhardt.polybar = {
    extraConfig = {
      "module/battery" = {
        "type" = "internal/battery";
        "battery" = "BAT0";
        "adapter" = "AC";
      };
    };
    primaryBarConfig = {
         "modules-right" = "battery date";
    };
  };

}

