{
  inputs,
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk-config.nix
  ];
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;
  environment.sessionVariables = {
    FLAKE = "/etc/nixos";
  };
  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    # pkgs.slack
    # pkgs.teams-for-linux
    pkgs.openvpn
  ];
  networking = {
    hostName = "work-laptop";
    networkmanager.enable = true;
  };
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  virtualisation.docker = {
    enable = true;
  };

  security.rtkit.enable = true;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   option = "--delete-older-than 10d";
    # };
  };
  services = {
    xserver.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    cli-environment.enable = true;
    # desktop-apps.enable = true;
    dev-environment.enable = true;
    fonts.enable = true;
    window-manager.enable = true;
  };
  users.users = {
    xmorel = {
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      initialPassword = "toto";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBd3US4tUcbWZQgcVOtZIcbHF5mHwzJzygrQuE/pGde6"
      ];
    };
    root = {
      initialPassword = "toto";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBd3US4tUcbWZQgcVOtZIcbHF5mHwzJzygrQuE/pGde6"
      ];
    };
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "xmorel" = import ./home.nix;
    };
  };

  stylix = {
    enable = true;
    image = ../../wall.jpg;
    polarity = "dark";
    opacity.terminal = 0.9;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 11;
        popups = 12;
      };
    };
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
