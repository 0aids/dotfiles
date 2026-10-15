{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
  };
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      xwayland-satellite # xwayland support
    ]
  );

  services.displayManager.dms-greeter = {
    enable = true;
    configHome = "/home/aids";
    configFiles = [ "/home/aids/.config/DankMaterialShell/settings.json" ];
    compositor.name = "niri";
  };
  services.displayManager.defaultSession = lib.mkForce "niri";
}
