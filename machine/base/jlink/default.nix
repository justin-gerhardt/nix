{ config, pkgs, lib, ... }:
let jlink = (pkgs.callPackage ./jlink.nix { });
in {

  services.udev.packages = [ jlink ];
  environment.systemPackages = [ jlink ];
}

