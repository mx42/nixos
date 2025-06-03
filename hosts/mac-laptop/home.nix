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
      eza 
      bat
      ripgrep
      fzf
      tree
    ];
    shell.enableFishIntegration = true;
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  programs = {
    btop = {
      enable = true;
      settings.vim_keys = true;
    };
    nh = {
      enable = true;
    };
    gh.enable = true;
    home-manager.enable = true;
    direnv.enable = true;
    nix-your-shell.enable = true;
    starship.enable = true;
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza --icons";
        cat = "bat";
        ll = "eza -lh --icons --group-directories-first";
        l = "eza -lh --icons --group-directories-first";
        la = "eza -lah --icons --group-directories-first";
      };
    };
  };

  home.stateVersion = "23.11";
}
