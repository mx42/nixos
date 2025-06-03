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
      tree
    ];
    shell.enableFishIntegration = true;
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  programs = {
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
    home-manager.enable = true;
    jujutsu.enable = true;
    nh.enable = true;
    nix-your-shell.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    yazi = {
      enable = true;
    };
  };

  home.stateVersion = "23.11";
}
