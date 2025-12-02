{
  inputs,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  myNixOS = {
    home-users = {
      "xmorel" = {
        userConfig = ./home.nix;
      };
    };
    archetype.general.enable = true;
    feature.fonts.enable = true;
    feature.virtualisation.enable = true;
  };

  boot = {
    loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "coretemp"
      "cpuid"
    ];
    kernelParams = [
      "quiet"
      "amd_pstate=guided"
      "processor.max_cstate=1"
    ];
    initrd.kernelModules = [ "amdgpu" ];
    plymouth.enable = true;
  };
  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.wlrobs ];
  };
  programs = {
    niri.enable = true; # test...
    # xwayland.enable = true;
  };
  hardware = {
    sane.enable = true;
    graphics.enable = true;
  };
  networking.hostName = "work-laptop";
  nix.settings.trusted-users = [
    "root"
    "xmorel"
  ];
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };
  security.sudo.wheelNeedsPassword = false;
  services = {
    # auto-cpufreq.enable = true;
    xserver.videoDrivers = [ "amdgpu" ];
    upower.enable = true;
    power-profiles-daemon.enable = true;
    tailscale.enable = true;
    tailscale.useRoutingFeatures = "client";
  };
  environment.systemPackages = [
    pkgs.pavucontrol
    pkgs.swaylock
    pkgs.xwayland-satellite
  ];
  programs.wireshark.enable = true;

  system.stateVersion = "24.05";
}
