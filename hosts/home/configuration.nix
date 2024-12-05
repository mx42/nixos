{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/apps" = {
    device = "/dev/disk/by-label/Apps";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };

  fileSystems."/mnt/photos" = {
    device = "/dev/disk/by-label/Photos";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };

  fileSystems."/mnt/ext" = {
    device = "/dev/disk/by-label/Externe";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };

  networking.hostName = "arcueid"; # Define your hostname.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.networkmanager.enable = true;

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

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };
  services.printing.enable = true;
  # TODO Add Scanner configuration

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.yoru = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Yoru";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    
    ];
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "yoru" = import ./home.nix;
    };
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    logiops
  ];

  services.cli-environment.enable = true;
  services.desktop-apps.enable = true;
  services.dev-environment.enable = true;
  services.gaming.enable = true;
  services.fonts.enable = true;
  services.window-manager.enable = true;

  system.stateVersion = "24.05";
}
