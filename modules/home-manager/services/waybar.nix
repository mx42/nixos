{
  pkgs,
  lib,
  config,
  ...
}:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
in
{
  options.myHome.services.waybar.enable = lib.mkEnableOption "enables waybar";

  config = lib.mkIf config.myHome.services.waybar.enable {
    services.swaync = {
      enable = true;
      package = pkgs.swaynotificationcenter;
      settings = {
        "widgets" = [
          "dnd"
          "mpris"
          "volume"
          "title"
          "notifications"
        ];
      };
    };

    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          position = "top";
          modules-center = [ "hyprland/workspaces" ];
          modules-left = [
            "custom/startmenu"
            "hyprland/window"
            "pulseaudio"
            "cpu"
            "memory"
            "idle_inhibitor"
          ];
          modules-right = [
            "custom/notification"
            "custom/exit"
            "battery"
            "tray"
            "clock"
          ];
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "一";
              "2" = "二";
              "3" = "三";
              "4" = "四";
              "5" = "五";
              "6" = "六";
              "7" = "七";
              "8" = "八";
              "9" = "九";
              "10" = "十";
            };
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };
          "clock" = {
            format = '' {:L%H:%M}'';
            tooltip = true;
            tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
          };
          "hyprland/window" = {
            max-length = 22;
            separate-outputs = false;
            rewrite = {
              "" = " 🙈 No Windows? ";
            };
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
          };
          "cpu" = {
            interval = 5;
            format = " {usage:2}%";
            tooltip = true;
          };
          "disk" = {
            format = " {free}";
            tooltip = true;
          };
          "network" = {
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            format-ethernet = " {bandwidthDownOctets}";
            format-wifi = "{icon} {signalStrength}%";
            format-disconnected = "󰤮";
            tooltip = false;
          };
          "tray" = {
            spacing = 12;
          };
          "pulseaudio" = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "sleep 0.1 && pavucontrol";
          };
          "custom/exit" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && wlogout";
          };
          "custom/startmenu" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && rofi -show drun -modi run,drun,filebrowser,window";
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
            tooltip = "true";
          };
          "custom/notification" = {
            tooltip = true;
            format = "{icon} {}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "sleep 0.1 && ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
            on-click-right = "sleep 0.1 && ${pkgs.swaynotificationcenter}/bin/swaync-client -d -sw";
            escape = true;
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󱘖 {capacity}%";
            format-icons = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            on-click = "";
            tooltip = false;
          };
        }
      ];
      style = ''
        * {
          font-family: JetBrainsMono Nerd Font Mono;
          font-size: 16px;
          border-radius: 0px;
          border: none;
          min-height: 0px;
        }
        window#waybar {
          background: rgba(0,0,0,0);
        }
        #workspaces {
          color: #${config.stylix.base16Scheme.base00};
          background: #${config.stylix.base16Scheme.base01};
          margin: 4px 4px;
          padding: 5px 5px;
          border-radius: 16px;
        }
        #workspaces button {
          font-weight: bold;
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 16px;
          color: #${config.stylix.base16Scheme.base00};
          background: linear-gradient(45deg, #${config.stylix.base16Scheme.base08}, #${config.stylix.base16Scheme.base0D});
          opacity: 0.5;
          transition: ${betterTransition};
        }
        #workspaces button.active {
          font-weight: bold;
          padding: 0px 5px;
          margin: 0px 3px;
          border-radius: 16px;
          color: #${config.stylix.base16Scheme.base00};
          background: linear-gradient(45deg, #${config.stylix.base16Scheme.base08}, #${config.stylix.base16Scheme.base0D});
          transition: ${betterTransition};
          opacity: 1.0;
          min-width: 40px;
        }
        #workspaces button:hover {
          font-weight: bold;
          border-radius: 16px;
          color: #${config.stylix.base16Scheme.base00};
          background: linear-gradient(45deg, #${config.stylix.base16Scheme.base08}, #${config.stylix.base16Scheme.base0D});
          opacity: 0.8;
          transition: ${betterTransition};
        }
        tooltip {
          background: #${config.stylix.base16Scheme.base00};
          border: 1px solid #${config.stylix.base16Scheme.base08};
          border-radius: 12px;
        }
        tooltip label {
          color: #${config.stylix.base16Scheme.base08};
        }
        #window, #pulseaudio, #cpu, #memory, #idle_inhibitor {
          font-weight: bold;
          margin: 4px 0px;
          margin-left: 7px;
          padding: 0px 18px;
          background: #${config.stylix.base16Scheme.base04};
          color: #${config.stylix.base16Scheme.base00};
          border-radius: 24px 10px 24px 10px;
        }
        #custom-startmenu {
          color: #${config.stylix.base16Scheme.base0B};
          background: #${config.stylix.base16Scheme.base02};
          font-size: 28px;
          margin: 0px;
          padding: 0px 30px 0px 15px;
          border-radius: 0px 0px 40px 0px;
        }
        #custom-hyprbindings, #network, #battery,
        #custom-notification, #tray, #custom-exit {
          font-weight: bold;
          background: #${config.stylix.base16Scheme.base0F};
          color: #${config.stylix.base16Scheme.base00};
          margin: 4px 0px;
          margin-right: 7px;
          border-radius: 10px 24px 10px 24px;
          padding: 0px 18px;
        }
        #clock {
          font-weight: bold;
          color: #0D0E15;
          background: linear-gradient(90deg, #${config.stylix.base16Scheme.base0E}, #${config.stylix.base16Scheme.base0C});
          margin: 0px;
          padding: 0px 15px 0px 30px;
          border-radius: 0px 0px 0px 40px;
        }
      '';
    };
  };
}
