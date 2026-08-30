{
  config,
  lib,
  pkgs,
  zen-browser,
  ...
}: {
  environment.systemPackages = lib.mkAfter (with pkgs; [
    # gui stuff
    floorp-bin
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    foot
    qt6Packages.qt6ct
    kdePackages.dolphin
    easyeffects
    zathura
    zotero
    mpv
    fontconfig
    kitty
  ]);

  fonts = {
      enableDefaultPackages = lib.mkDefault true;
      packages =  lib.mkAfter (with pkgs.nerd-fonts; [
          iosevka
          blex-mono
      ]);
  };
}
