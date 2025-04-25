{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.services.dev-environment;
in
{
  imports = [ ];

  options.services.dev-environment = {
    enable = mkEnableOption "enable dev-environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # docker
      # docker-compose
      git
      gh
      jujutsu
      lazyjj # jjui
      commitizen
      pre-commit
      devenv
      # cargo
      # rustup
      python312
      lua
      lua52Packages.luarocks
      ghostscript
      tectonic
      mermaid-cli
      lazygit
    ];
    programs = {
      neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;
      };
    };
  };
}
