{
  pkgs,
  config,
  lib,
  ...
}:
let
  drawing-apps = with pkgs; [
    gimp
    # tiled
    # aseprite
    # inkscape
    sweethome3d.application
  ];
  printing-apps = with pkgs; [
    blender
    # prusa-slicer
    # openscad
  ];
  gamedev-apps = with pkgs; [
    # godot_4
    # gdtoolkit_4
  ];
  sound-apps = with pkgs; [
    audacity
    # sfxr
  ];
in
{
  options.myHome.programs.creativity = lib.mkOption {
    type = lib.types.submodule {
      options = {
        drawing.enable = lib.mkEnableOption "enable drawing software";
        printing.enable = lib.mkEnableOption "enable 3d (printing) software";
        gamedev.enable = lib.mkEnableOption "enable gamedev software";
        sound.enable = lib.mkEnableOption "enable sound making software";
      };
    };
    default = { };
  };

  config.home.packages = lib.concatLists [
    (lib.optionals config.myHome.programs.creativity.drawing.enable drawing-apps)
    (lib.optionals config.myHome.programs.creativity.printing.enable printing-apps)
    (lib.optionals config.myHome.programs.creativity.gamedev.enable gamedev-apps)
    (lib.optionals config.myHome.programs.creativity.sound.enable sound-apps)
  ];
}
