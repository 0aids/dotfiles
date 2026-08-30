{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;
  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    configHome = "/home/aids";
    configFiles = ["/home/aids/.config/DankMaterialShell/settings.json"];
    compositor.name = "niri";
  };
}
