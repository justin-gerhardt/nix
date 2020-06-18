{ config, pkgs, lib, ... }:
let private = import ../private;
in {
  imports = [ ../user/laptop ./base ];

  hardware.acpilight.enable = true;
  users.users.justin.extraGroups = [ "video" ];
  services.xserver.libinput = {
    enable = true;
    accelProfile = "flat";
  };
  networking.wireless = {
    enable = true;
    networks = private.wifi.Peters;
  };
  networking = {
    hostName = "gerhardt-laptop";
    hostId = "abcdef02";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp1s0.useDHCP = true;
  };
}

