{
  pkgs,
  ...
}:

{
  home = {
    username = "xmorel";
    homeDirectory = "/Users/xmorel/";
    sessionVariables = {
      FLAKE = "/Users/xmorel/workspace/nixos/";
    };
    packages = with pkgs; [
      asciinema_3
      aws-vault
      docker-compose-language-service
      pyright
      tree
    ];
    shell.enableFishIntegration = true;
  };

  nix = {
    package = pkgs.nix;
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = [
        "root" "xmorel"
      ];
    };
    gc = {
      automatic = true;
    };
    extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };

  programs = {
    awscli.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batwatch ];
    };
    btop = {
      enable = true;
      settings.vim_keys = true;
    };
    direnv.enable = true;
    eza = {
      enable = true;
      extraOptions = ["--group-directories-first"];
      git = true;
      icons = "auto";
    };
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza";
        cat = "bat";
        ll = "eza -lh";
        l = "eza -lh";
        la = "eza -lah";
        man = "batman";
      };
    };
    fzf.enable = true;
    gh.enable = true;
    gpg.enable = true;
    home-manager.enable = true;
    jujutsu.enable = true;
    nh.enable = true;
    nix-your-shell.enable = true;
    password-store.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    yazi = {
      enable = true;
    };
  };

  home.stateVersion = "23.11";
}
