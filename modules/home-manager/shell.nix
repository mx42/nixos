{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    myHome.shell.enable = lib.mkEnableOption "enables shell stuff";
  };

  config = lib.mkIf config.myHome.shell.enable {
    home.packages = [
      pkgs.aoc-cli
      pkgs.neofetch
      pkgs.typst
    ];
    programs.fish = {
      enable = true;
    };
  };
}
