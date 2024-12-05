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
    home.packages = with pkgs; [
      aoc-cli
      just
      neofetch
      typst
    ];
    programs.fish = {
      enable = true;
    };
  };
}
