{ config, pkgs, lib, ... }: {

  # adding xdg-open and it's depends to path so that kdeconnect can actually open things
  nixpkgs.config.packageOverrides = pkgs: {
    kdeconnect =
      pkgs.symlinkJoin {
        name = "kdeconnect";
        paths = [ pkgs.kdeconnect ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/libexec/kdeconnectd --prefix PATH : ${
            lib.makeBinPath [ pkgs.xdg_utils pkgs.coreutils-full pkgs.which ]
          }
        '';
      };
  };

  systemd.user.services.kdeconnect.Unit.Requires = [ "dbus.service" ];
  services.kdeconnect.enable = true;

}
