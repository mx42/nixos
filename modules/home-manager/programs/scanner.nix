{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.myHome.programs.scanner.enable = lib.mkEnableOption "enable scanner software";
  config = lib.mkIf config.myHome.programs.scanner.enable {
    home.packages = with pkgs; [
      xsane
      sane-frontends
    ];
  };
}
