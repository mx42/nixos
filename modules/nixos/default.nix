{
  inputs,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.home-manager.nixosModules.home-manager
    inputs.determinate.nixosModules.default

    ./archetypes
    ./features
    ./home-manager.nix

    # ./desktop-apps.nix
    # ./fonts.nix
    # ./gaming.nix
  ];

  config = {
    programs.dconf.enable = true;
    programs.hyprland.enable = true;
    services.xserver = {
      displayManager = {
        defaultSession = "hyprland";
      };
    };
    xdg.portal.enable = true;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
