{
  lib,
  config,
  ...
}:
{
  options.myHome.programs.kitty.enable = lib.mkEnableOption "enables kitty";

  config = lib.mkIf config.myHome.programs.kitty.enable {
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
        background_opacity = "0.6";
        background_blur = 3;
        font_family = "Fira Code";
      };
      # extraConfig = ''
      #   tab_bar_style fade
      #   tab_fade 1
      #   active_tab_font_style bold
      #   inactive_tab_font_style bold
      # '';
    };
  };
}
