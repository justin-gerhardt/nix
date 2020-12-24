{ pkgs ? import <nixpkgs> { } }:

# Add support for syncing volume level with bluetooth headset

pkgs.pulseaudioFull.overrideAttrs (oldAttrs: rec {
    patches = (if oldAttrs ? patches then oldAttrs.patches else [ ]) ++ [
        ./bluetooth_volume.patch
    ];
})


