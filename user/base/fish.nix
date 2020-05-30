{ config, pkgs, ... }:

{

  home.packages = with pkgs; [ pkgs.python38Packages.powerline ];

  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
      powerline-setup

      if status is-login
        if test -z "$DISPLAY" -a $XDG_VTNR = 1
          exec startx -- -keeptty
        end
      end
    '';

    functions = {
      fish_user_key_bindings = {
        body = ''
          bind \cs 'prepend_command sudo'
        '';
      };
      prepend_command = {
        body = ''
          set -l prepend $argv[1]
          if test -z "$prepend"
            echo "prepend_command needs one argument."
            return 1
          end

          set -l cmd (commandline)
          if test -z "$cmd"
            commandline -r $history[1]
          end

          set -l old_cursor (commandline -C)
          commandline -C 0
          commandline -i "$prepend "
          commandline -C (math $old_cursor + (echo $prepend | wc -c))
        '';
      };
    };
  };
}
