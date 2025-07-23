{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.services.cli-environment;
in
{
  imports = [ ];

  options.services.cli-environment = {
    enable = mkEnableOption "enable cli-environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openssl
      nixfmt-rfc-style
      nil
      ripgrep
      fd
      clang
    ];
    programs.fish.enable = true;
  };
}
