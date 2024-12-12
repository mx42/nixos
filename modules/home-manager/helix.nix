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
          # [editor.inline-diagnostics]
          # cursor-line = "warning"
        };

# [[language]]
# name = "python"
# language-servers = ["pylsp"]

# [language-server.pylsp.config.pylsp]
# plugins.pyls_mypy.enabled = true
# plugins.pyls_mypy.live_mode = true
      
            
                  
      };
    };
  };
}
