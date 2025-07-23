{
  ...
}:
{
  myHome = {
    services.nix.enable = true;
    bundle.work-apps.enable = true;
    bundle.myhypr.enable = true;
    bundle.desktop-apps.enable = true;
    bundle.shell.enable = true;
  };

  home = {
    username = "xmorel";
    homeDirectory = "/home/xmorel";
    shell.enableFishIntegration = true;
    stateVersion = "23.11";
  };
  programs.git = {
    userName = "Xavier Morel";
    userEmail = "morelx42@gmail.com";
  };
  programs.home-manager.enable = true;
}
