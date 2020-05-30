{ config, pkgs, lib, ... }: {

  # adding xdg-open and it's depends to path so that kdeconnect can actually open things
  nixpkgs.config.packageOverrides = pkgs: {
    kdeconnect = pkgs.kdeconnect.overrideAttrs (old: rec {
      postInstall = old.postInstall + ''
        wrapProgram $out/libexec/kdeconnectd --prefix PATH : ${
          lib.makeBinPath [ pkgs.xdg_utils pkgs.coreutils-full pkgs.which ]
        }
      '';
    });
  };
  systemd.user.services.kdeconnect.Unit.Requires = [ "dbus.service" ];
  services.kdeconnect.enable = true;

}
