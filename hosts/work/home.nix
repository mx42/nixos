{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  myHome = {
    services.nix.enable = true;
    bundle.work-apps.enable = true;
    bundle.myhypr.enable = false;
    bundle.desktop-apps.enable = true;
    bundle.shell.enable = true;
    programs.creativity = {
      drawing.enable = true;
      printing.enable = true;
      gamedev.enable = true;
      sound.enable = true;
    };
  };

  home = {
    username = "xmorel";
    homeDirectory = "/home/xmorel";
    shell.enableFishIntegration = true;
    stateVersion = "23.11";
  };
  programs.git = {
    settings.user = {
      name = "Xavier Morel";
      email = "morelx42@gmail.com";
    };
  };
  programs.home-manager.enable = true;
  programs = {
    rofi.enable = true;
    noctalia-shell.enable = true;
    quickshell.enable = true;
    alacritty.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };
}
