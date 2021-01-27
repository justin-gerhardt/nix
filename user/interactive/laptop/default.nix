{ config, pkgs, lib, ... }:

{
  home-manager.users.justin = {
    home.packages = with pkgs; [ acpilight ];
    gerhardt.polybar = {
      extraConfig = {
        "module/battery" = {
          "type" = "internal/battery";
          "battery" = "BAT0";
          "adapter" = "AC";
        };
      };
      primaryBarConfig = { "modules-right" = "a battery date"; };
    };
  };
}

