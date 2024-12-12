{ config, pkgs, lib, outputs, ... }:

{
  home.username = "xmorel";
  home.homeDirectory = "/home/xmorel";

  imports = [
    ../../modules/home-manager/dotfiles.nix
    ../../modules/home-manager/helix.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/kitty.nix
  ];

  # myHome.dotfiles.enable = true;
  myHome.helix.enable = true;
  # myHome.waybar.enable = true;
  myHome.kitty.enable = true;
  myHome.shell.enable = true;

  # TODO Move somewhere...
  # programs.spotify-player.enable = true;  

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
