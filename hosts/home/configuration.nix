{
  config,
  pkgs,
  inputs,
  nixpkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    # inputs.home-manager.nixosModules.default
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
      trusted-users = [
        "root"
        "yoru"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
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
    graphics.enable = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  environment = {
    sessionVariables = {
      FLAKE = "/home/yoru/nixos";
      DIRENV_LOG_FORMAT = "";
    };
    systemPackages = with pkgs; [
      vial
    ];
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
    udev.packages = with pkgs; [
      vial
    ];
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null;
      };
    };
    pulseaudio.enable = false;
    xserver.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
    blueman.enable = true;
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
    firefly-iii-data-importer = {
      enable = true;
      enableNginx = true;
      settings = {
        FIREFLY_III_URL_FILE = "/home/yoru/.firefly-url.txt";
        VANITY_URL_FILE = "/home/yoru/.firefly-vanity-url.txt";
        FIREFLY_III_CLIENT_ID = 2;
      };
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
      "docker"
      "cdrom"
    ];
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "yoru" = import ./home.nix;
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
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  system.stateVersion = "24.05";
}
