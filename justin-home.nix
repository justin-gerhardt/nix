{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];
  home-manager.users.justin = (import ./home.nix);

}
