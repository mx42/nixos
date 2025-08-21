{
  pkgs,
  lib,
  config,
  ...
}:
let
  active_gradient = "rgb(${config.stylix.base16Scheme.base08}) rgb(${config.stylix.base16Scheme.base0D}) 45deg";
in
{
  options.myHome.services.hyprland.enable = lib.mkEnableOption "enables hyprland";

  config = lib.mkIf config.myHome.services.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        # hyprland.conf
        "$mainMod" = "SUPER";

        # defaults.conf
        "$filemanager" = "thunar";
        "$applauncher" = "rofi -show combi -modi window,run,combi -combi-modi window,run";
        "$terminal" = "kitty";
        "$idlehandler" =
          "swayidle -w timeout 300 'swaylock -f -c 000000' before-sleep 'swaylock -f -c 000000'";
        "$capturing" = "grim -g \"$(slurp)\" - | swappy -f -";

        # autostart.conf
        exec-once = [
          "tailscale-systray &"
          "slack &"
          "waybar &"
          "fcitx5 -d &"
          "mako &"
          "nm-applet --indicator &"
          "$idlehandler"
        ];

        # decorations.conf
        decoration = {
          active_opacity = 1;
          inactive_opacity = 0.9;
          rounding = 8;
          blur = {
            enabled = true;
            size = 15;
            passes = 2;
            xray = true;
            new_optimizations = "on";
            ignore_opacity = "off";
            vibrancy = 0.1696;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            # color = "rgba(1a1a1aee)";
          };
        };

        # environment.conf
        envd = [
          "HYPRCURSOR_SIZE,24"
          "XCURSOR_SIZE,24"
          "QT_CURSOR_SIZE,24"
          "XDG_CURRENT_DESKTOP, Hyprland"
          "XDG_SESSION_TYPE, Hyprland"
          "XDG_SESSION_DESKTOP, Hyprland"
          "GDK_BACKEND, wayland, x11"
          "CLUTTER_BACKEND, wayland"
          "QT_QPA_PLATFORM=wayland;xcb"
          "MOZ_ENABLE_WAYLAND, 1"
        ];

        # input.conf
        input = {
          kb_layout = "us,us_intl";
          kb_variant = "";
          kb_model = "";
          kb_options = "grp:win_space_toggle";
          kb_rules = "";
          follow_mouse = 2;
          float_switch_override_focus = 2;
        };

        # keybinds.conf
        bindl = [
          ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, 1920x1200, 0x0, 1\""
          ", switch:on:Lid Switch,  exec, hyprctl keyword monitor \"eDP-1, disable\""
        ];

        bindd = [
          "$mainMod, RETURN, Opens your preferred terminal emulator ($terminal), exec, $terminal"
          "$mainMod, E, Opens your preferred filemanager ($filemanager), exec, $filemanager"
          "$mainMod, A, Screen capture selection, exec, $capturing"
          "$mainMod, Q, Closes (not kill) current window, killactive,"
          "$mainMod SHIFT, M, Exits Hyprland by terminating the user sessions, exec, loginctl terminate-user \"\" "
          "$mainMod, V, Switches current window between floating and tiling mode, togglefloating,"
          "$mainMod, R, Runs your application launcher, exec, $applauncher"
          "$mainMod, F, Toggles current window fullscreen mode, fullscreen"
          "$mainMod, Y, Pin current window (shows on all workspaces),pin"
          "$mainMod, J, Toggles curren window split mode, togglesplit, # dwindle"
          "$mainMod, K, Toggles current window group mode (ungroup all related), togglegroup,"
          "$mainMod, Tab, Switches to the next window in the group, changegroupactive, f"
          "$mainMod SHIFT, L, Lock the screen, exec, swaylock -e -K -p 10"
          "$mainMod, mouse:272, Move the window towards a direction, movewindow"
          "$mainMod CTRL, 1, Move window and switch to workspace 1, movetoworkspace, 1"
          "$mainMod CTRL, 2, Move window and switch to workspace 2, movetoworkspace, 2"
          "$mainMod CTRL, 3, Move window and switch to workspace 3, movetoworkspace, 3"
          "$mainMod CTRL, 4, Move window and switch to workspace 4, movetoworkspace, 4"
          "$mainMod CTRL, 5, Move window and switch to workspace 5, movetoworkspace, 5"
          "$mainMod CTRL, 6, Move window and switch to workspace 6, movetoworkspace, 6"
          "$mainMod CTRL, 7, Move window and switch to workspace 7, movetoworkspace, 7"
          "$mainMod CTRL, 8, Move window and switch to workspace 8, movetoworkspace, 8"
          "$mainMod CTRL, 9, Move window and switch to workspace 9, movetoworkspace, 9"
          "$mainMod CTRL, 0, Move window and switch to workspace 10, movetoworkspace, 10"
          "$mainMod CTRL, left, Move window and switch to the next workspace, movetoworkspace, -1"
          "$mainMod CTRL, right, Move window and switch to the previous workspace, movetoworkspace, +1"
          "$mainMod SHIFT, 1, Move window silently to workspace 1, movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, Move window silently to workspace 2, movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, Move window silently to workspace 3, movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, Move window silently to workspace 4, movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, Move window silently to workspace 5, movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, Move window silently to workspace 6, movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, Move window silently to workspace 7, movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, Move window silently to workspace 8, movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, Move window silently to workspace 9, movetoworkspacesilent, 9"
          "$mainMod SHIFT, 0, Move window silently to workspace 10, movetoworkspacesilent, 10"
          "$mainMod, 1, Switch to workspace 1, workspace, 1"
          "$mainMod, 2, Switch to workspace 2, workspace, 2"
          "$mainMod, 3, Switch to workspace 3, workspace, 3"
          "$mainMod, 4, Switch to workspace 4, workspace, 4"
          "$mainMod, 5, Switch to workspace 5, workspace, 5"
          "$mainMod, 6, Switch to workspace 6, workspace, 6"
          "$mainMod, 7, Switch to workspace 7, workspace, 7"
          "$mainMod, 8, Switch to workspace 8, workspace, 8"
          "$mainMod, 9, Switch to workspace 9, workspace, 9"
          "$mainMod, 0, Switch to workspace 10, workspace, 10"
          "$mainMod, PERIOD, Scroll through workspaces incrementally, workspace, e+1"
          "$mainMod, COMMA, Scroll through workspaces decrementally, workspace, e-1"
          "$mainMod, minus, Move active window to Special workspace, movetoworkspace,special"
          "$mainMod, slash, Toggles the Special workspace, togglespecialworkspace, special"
        ];
        bindm = [
          "$mainMod, mouse:273, resizewindow	#Resize the window towards a direction"
          "$mainMod, mouse:272, movewindow		#Drag window"
        ];

        binds = {
          allow_workspace_cycles = 1;
          workspace_back_and_forth = 1;
          workspace_center_on = 1;
          movefocus_cycles_fullscreen = true;
          window_direction_monitor_fallback = true;
        };

        # variables.conf
        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 2;
          layout = "dwindle";
          snap.enabled = true;
          "col.active_border" = lib.mkForce active_gradient;
        };
        group = {
          "col.border_active" = lib.mkForce active_gradient;
        };
        render.direct_scanout = true;
        dwindle = {
          special_scale_factor = 0.8;
          pseudotile = true;
          preserve_split = true;
        };
        master = {
          new_status = "master";
          special_scale_factor = 0.8;
        };
        misc = {
          focus_on_activate = true;
          vrr = 2;
          enable_anr_dialog = false; # "application not responding"
        };
        # windowrules.conf
        # ...
      };
    };

    home.packages = with pkgs; [
      libnotify
      xclip
      wl-clipboard
      hyprpaper
      libnotify
      hyprpicker
      slurp
      swappy
      grim
    ];
    programs = {
      rofi.enable = true;
      swaylock.enable = true;
    };

    services = {
      picom.enable = true;
      hyprsunset.enable = true;
      mako.enable = true;
      swayidle.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal
      ];
    };
  };
}
