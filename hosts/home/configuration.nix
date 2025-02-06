{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot = {
    loader.grub.enable = true;
    loader.grub.device = "/dev/sda";
    loader.grub.useOSProber = true;
    supportedFilesystems = [ "ntfs" ];
    # tmp = {
    #   useTmpfs = false;
    #   tmpfsSize = "30%";
    # };
  };

  fileSystems."/mnt/apps" = {
    device = "/dev/disk/by-label/Apps";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  fileSystems."/mnt/photos" = {
    device = "/dev/disk/by-label/Photos";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  fileSystems."/mnt/ext" = {
    device = "/dev/disk/by-label/Externe";
    fsType = "ntfs-3g";
    options = [
      "auto"
      "nofail"
      "noatime"
      "rw"
      "uid=1000"
    ];
  };

  networking.hostName = "arcueid"; # Define your hostname.
  networking.networkmanager.enable = true;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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

  hardware = {
    sane.enable = true;
    pulseaudio.enable = false;
    graphics.enable = true;
  };

  environment.sessionVariables = {
    FLAKE = "/home/yoru/nixos";
  };

  security = {
    rtkit.enable = true;
    sudo.extraRules = [
      {
        users = [ "yoru" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  services = {
    xserver.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # my modules
    cli-environment.enable = true;
    desktop-apps.enable = true;
    dev-environment.enable = true;
    gaming.enable = true;
    fonts.enable = true;
    window-manager.enable = true;
  };

  users.users.yoru = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Yoru";
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
      "lp"
    ];
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "yoru" = import ./home.nix;
    };
  };
  nixpkgs.config.allowUnfree = true;

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

  system.stateVersion = "24.05";
}
