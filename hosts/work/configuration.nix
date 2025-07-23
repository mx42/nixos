{
  inputs,
  outputs,
  myLib,
  modulesPath,
  lib,
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
  };

  boot = {
    loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
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

  hardware = {
    sane.enable = true;
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
  services.auto-cpufreq.enable = true;
  security.sudo.wheelNeedsPassword = false;
  services.xserver.videoDrivers = [ "amdgpu" ];
  virtualisation.docker.enable = true; # feature virtualisation

  system.stateVersion = "24.05";
}
