{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.myHome.programs.creativity.enable = lib.mkEnableOption "enable creativity software";
  config = lib.mkIf config.myHome.programs.creativity.enable {
    home.packages = with pkgs; [
      blender
      tiled
      aseprite
      inkscape

      prusa-slicer
      openscad

      godot_4
      gdtoolkit_4

      audacity
      sfxr
    ];
  };
}
