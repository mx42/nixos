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

  myHome.dotfiles.enable = true;
  myHome.helix.enable = true;
  myHome.waybar.enable = true;
  myHome.kitty.enable = true;
  myHome.shell.enable = true;

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs = {
    firefox.enable = true;
    gh.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    home-manager.enable = true;
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 10;
          hide_cursor = true;
          no_fade_in = false;
        };
      };
    };
  };

  home.stateVersion = "23.11";
}
