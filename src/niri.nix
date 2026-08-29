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
    compositor.name = "niri";
  };
  environment.systemPackages = lib.mkAfter (with pkgs; [
    # gui stuff
    floorp-bin
    foot
  ]);
}
