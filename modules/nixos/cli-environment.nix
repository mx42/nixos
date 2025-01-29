{ pkgs, lib, config, ... }:
with lib;
let 
  cfg = config.services.cli-environment;
in
{
  imports = [];

  options.services.cli-environment = {
    enable = mkEnableOption "enable cli-environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
      wget
      killall
      htop
      p7zip
      unzip
      unrar
      helix
      direnv
      git
      bat
      tree
      imv
      eza  # ?
      appimage-run
      nh
      openssl
    ];
    programs.fish.enable = true;
  };
}
