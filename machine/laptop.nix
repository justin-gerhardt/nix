{ config, pkgs, lib, ... }:

{
  imports = [ ../user/laptop ./base.nix ];

  services.xserver.libinput = {
    enable = true;
    accelProfile = "flat";
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

