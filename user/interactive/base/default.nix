{ config, pkgs, ... }:

{
  home-manager.users.justin = (import ./home.nix);
}
