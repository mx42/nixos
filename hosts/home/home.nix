{
  config,
  pkgs,
  lib,
  outputs,
  ...
}:

{
  home.username = "yoru";
  home.homeDirectory = "/home/yoru";

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

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/yoru/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';

  home.packages = [
    (import ../../scripts/screenshot.nix { inherit pkgs; })
    (import ../../scripts/rainbow-border.nix { inherit pkgs; })
  ];

  # stylix.targets = {
  #   waybar.enable = false;
  #   rofi.enable = false;
  #   hyprland.enable = false;
  # };

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
  # qt = {
    # enable = true;
    # style.name = "adwaita-dark";
    # platformTheme.name = "gtk3";
  # };

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
