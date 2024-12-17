{
  lib,
  config,
  ...
}: let
  cfg = config.myHome.kitty;
in {
  options = {
    myHome.kitty.enable = lib.mkEnableOption "enables kitty";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = lib.mkForce {
      enable = true;
      keybindings = {
        "ctrl+left" = "previous_tab";
        "ctrl+right" = "next_tab";
        "ctrl+down" = "new_tab";
      };
      settings = {
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        mouse_hide_wait = "-1.0";
        background_opacity = "0.5";
        background_blur = 5;
        font_family = "Fira Code";
      };
      extraConfig = ''
        tab_bar_style fade
        tab_fade 1
        active_tab_font_style bold
        inactive_tab_font_style bold
      '';
    };
  };
}
