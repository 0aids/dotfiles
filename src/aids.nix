{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aids = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "greeter"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
    initialPassword = "nixos";
  };
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom=AU
  '';
}
