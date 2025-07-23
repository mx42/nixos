{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options.myNixOS.archetype.general.enable = lib.mkEnableOption "enable general archetype";
  config = lib.mkIf config.myNixOS.archetype.general.enable {
    myNixOS.features.stylix.enable = true;

    environment.systemPackages = [
      pkgs.openssl
      pkgs.coreutils
    ];
    hardware = {
      graphics.enable = true;
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };

    i18n = {
      defaultLocale = "fr_FR.UTF-8";
      extraLocaleSettings = {
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
    };
    networking.networkmanager.enable = true;
    security.rtkit.enable = true;

    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      blueman.enable = true;
      openssh.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      printing.enable = true;
      udev.packages = with pkgs; [
        vial
      ];
      xserver.enable = true;
    };

    time.timeZone = "Europe/Paris";
  };
}
