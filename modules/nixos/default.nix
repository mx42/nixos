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
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
