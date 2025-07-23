{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myHome.bundle.shell.enable = lib.mkEnableOption "enable shell bundle";

  config = lib.mkIf config.myHome.bundle.shell.enable {
    home.packages = with pkgs; [
      commitizen
      pre-commit
      curl
      devenv
      git
      just
      killall
      lazyjj
      neofetch
      p7zip
      ripgrep
      tree
      typst
      unrar
      unzip
      wget
      yt-dlp
    ];
    programs = {
      awscli.enable = true;
      bat = {
        enable = true;
        extraPackages = [ pkgs.bat-extras.batman ];
      };
      btop = {
        enable = true;
        settings.vim_keys = true;
      };
      direnv.enable = true;
      eza = {
        enable = true;
        extraOptions = [ "--group-directories-first" ];
        git = true;
        icons = "auto";
      };
      nix-your-shell = {
        enable = true;
        enableFishIntegration = true;
      };
      fish = {
        enable = true;
        shellAliases = {
          ls = "eza";
          cat = "bat";
          l = "eza -lh";
          ll = "eza -lh";
          la = "eza -lah";
          man = "batman";
          ".." = "cd ..";
        };
        interactiveShellInit = ''
          fish_vi_key_bindings
        '';
      };
      starship = {
        enable = true;
        enableFishIntegration = true;
      };
      fzf.enable = true;
      gh.enable = true;
      gpg.enable = true;
      jujutsu.enable = true;
      lazygit.enable = true;
      ripgrep.enable = true;
      yazi.enable = true;
    };
  };
}
