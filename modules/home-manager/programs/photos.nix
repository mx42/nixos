{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.myHome.programs.photos.enable = lib.mkEnableOption "enable photo software";
  config = lib.mkIf config.myHome.programs.photos.enable {
    home.packages = with pkgs; [
      # gimp
      rawtherapee
    ];
  };
}
