{
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home-manager/kitty.nix
  ];
  myHome = {
    kitty.enable = true;
  };
  home = {
    username = "xmorel";
    homeDirectory = "/home/xmorel/";
    sessionVariables = {
      FLAKE = "/home/xmorel/nixos/";
    };
    packages = with pkgs; [
      devenv
      lazyjj
      slack
      tailscale-systray
      tree
      ungoogled-chromium
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-volman
      yt-dlp
      vial
    ];
    file.".config/nvim" = {
      source = ../../dotfiles/nvim;
      recursive = true;
    };
    file.".config/hypr" = {
      source = ../../dotfiles/hypr;
      recursive = true;
    };
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
  	  extraPackages = with pkgs.bat-extras; [ batman ];
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
      interactiveShellInit =
        ''
        source /usr/share/cachyos-fish-config/cachyos-config.fish
        fish_vi_key_bindings
        '';
    };
    fzf.enable = true;
    gh.enable = true;
    gpg.enable = true;
    home-manager.enable = true;
    jujutsu.enable = true;
    lazygit.enable = true;
    nh.enable = true;
    nix-your-shell.enable = true;
    rbw.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    yazi.enable = true;
  };

  home.stateVersion = "23.11";
}
