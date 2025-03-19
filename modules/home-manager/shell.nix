{
  pkgs,
  lib,
  config,
  ...
}:
{
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
    programs.direnv = {
      enable = true;
    };
    programs.nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.fish = {
      enable = true;
      shellAliases = {
        ls = "eza --icons";
        cat = "bat";
        ll = "eza -lh --icons --grid --group-directories-first";
        la = "eza -lah --icons --grid --group-directories-first";
        ".." = "cd ..";
      };
    };
  };
}
