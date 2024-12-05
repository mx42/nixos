{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    myHome.dotfiles.enable = lib.mkEnableOption "enables dotfiles";
  };

  config = lib.mkIf config.myHome.dotfiles.enable {
    home.file = {
      ".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland.conf;
    };
  };
}
