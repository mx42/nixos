{
  pkgs,
  lib,
  config,
  ...
}: let
  waybarConfig = {
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
  };

  css = ''
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
in {
  options = {
    myHome.waybar.enable = lib.mkEnableOption "enables waybar";
  };

  config = lib.mkIf config.myHome.waybar.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      style = css;
      settings = {
        mainBar = waybarConfig;
      };
    };
  };
}
