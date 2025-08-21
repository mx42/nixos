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
  ];

  config = {
    programs.dconf.enable = true;
    programs.hyprland.enable = true;
    services.displayManager.defaultSession = "hyprland";
    services.chrony = {
      enable = true;
      enableNTS = true;
      servers = [ "time.cloudflare.com" ];
    };
    xdg.portal.enable = true;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nixpkgs.config.allowUnfree = true;
  };
}
