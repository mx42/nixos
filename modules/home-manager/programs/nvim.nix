{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.myHome.programs.nvim.enable = lib.mkEnableOption "enables neovim";

  config = lib.mkIf config.myHome.programs.nvim.enable {
    home.packages = with pkgs; [
      lua
      lua52Packages.luarocks
      ghostscript
      tectonic
      mermaid-cli
      lazygit
    ];
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
    };
    home.file.".config/nvim" = {
      source = ../../../dotfiles/nvim;
      recursive = true;
    };
  };
}
