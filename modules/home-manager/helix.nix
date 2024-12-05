{
  lib,
  config,
  ...
}: let
  cfg = config.myHome.helix;
in {
  options = {
    myHome.helix.enable = lib.mkEnableOption "enables helix";
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        editor = {
          lsp = {
            enable = true;
            display-messages = true;
            display-inlay-hints = true;
          };
        };
      };
    };
  };
}
