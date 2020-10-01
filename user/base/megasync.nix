{ pkgs, ... }: {

  systemd.user.services.megasync = {
    Unit.Description = [ "MegaSync desktop client" ];
    Service.ExecStart = "${pkgs.megasync}/bin/megasync";
    Install.WantedBy = [ "default.target" ];
  };

}
