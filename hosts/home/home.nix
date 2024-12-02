{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yoru";
  home.homeDirectory = "/home/yoru";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.helix
    pkgs.firefox
    # pkgs.zsh
    pkgs.bottles
    pkgs.neofetch
    # pkgs.steam
    # pkgs.discord

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yoru/etc/profile.d/hm-session-vars.sh
  #
  # home.sessionVariables = {
    # EDITOR = "hx"; # EDITOR = "emacs";
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        lsp = {
          enable = true;
          display-messges = true;
          display-inlay-hints = true;
        };
        "inline-diagnostics" = {
          cursor-line = "warning";
        };
      };
    };
  };
  # programs.steam.enable = true;
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      background_opacity = "0.5";
      background_blur = 5;
      font_family = "Fira Code";
    };
  };
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
      * {
        font-family: 'Fira Code', 'Symbols Nerd Font Mono';
        font-size: 16px;
        min-height: 45px;
      }
      window#waybar {
        background: transparent;
      }
      #workspaces, #clock, #pulseaudio, #network, #cpu, #memory, #backlight, #idle_inhibitor, #temperature, #custom-power {
        border-radius: 10px;
        background-color: rgba(10, 10, 10, 0.5);
        margin-top: 1px;
        padding-top: 5px;
        padding-left: 15px;
        padding-right: 10px;
        padding-bottom: 5px;
      }
      #workspaces button.active {
        color: #ebebeb;
      }
    '';
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "hyprland/workspaces"
        "custom/media"
      ];
      modules-center = [
        "hyprland/window"
      ];
      modules-right = [
        "mpd"
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "power-profiles-daemon"
        "cpu"
        "memory"
        "temperature"
        # "backlight"
        "keyboard-state"
        "clock"
        "tray"
        "custom/power"
      ];
      "hyprland/workspaces" = {
        "format" = "{icon}";
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
      };
      "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
              "activated" = "";
              "deactivated" = "";
          };
      };
      "tray" = {
          "spacing" = 10;
      };
      "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = false;
      };
      "memory" = {
          "format" = "{}% ";
      };
      "temperature" = {
          # // "thermal-zone" = 2;
          # // "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
          "critical-threshold" = 80;
          # // "format-critical" = "{temperatureC}°C {icon}";
          "format" = "{temperatureC}°C {icon}";
          "format-icons" = ["" "" ""];
      }; 
      "network" = {
          # // "interface" = "wlp2*"; // (Optional) To force the use of this interface
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
      };
      "pulseaudio" = {
          # // "scroll-step" = 1; // %, can be a float
          "format" = "{volume}% {icon} {format_source}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
              "headphone" = "";
              "hands-free" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = ["" "" ""];
          };
          "on-click" = "pavucontrol";
      };
      "custom/media" = {
          "format" = "{icon} {text}";
          "return-type" = "json";
          "max-length" = 40;
          "format-icons" = {
              "spotify" = "";
              "default" = "🎜";
          };
          "escape" = true;
          "exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # // Script in resources folder
          # // "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
      };
      "custom/power" = {
        "format" = "⏻ ";
        "tooltip" = false;
    		"menu" = "on-click";
    		"menu-file" = "$HOME/.config/waybar/power_menu.xml"; # // Menu file in resources folder
    		"menu-actions" = {
    			"shutdown" = "shutdown";
    			"reboot" = "reboot";
    			"suspend" = "systemctl suspend";
    			"hibernate" = "systemctl hibernate";
    		};
      };
    }];
  };
}
