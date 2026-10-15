{
  config,
  lib,
  pkgs,
  zen-browser,
  ...
}:
let
  pinnedPkgsForZotero =
    import
      (builtins.fetchTarball {
        url = "https://github.com/nixos/nixpkgs/archive/c27cdad491a991b11ed731760aa2ef8db0cb0410.tar.gz";
        sha256 = "1r58xn9xdka8bw710i431srl3dmy7dyrhd32rjv709f2mkb6m1ix";
      })
      {
        inherit (pkgs) system;
        config = pkgs.config;
        overlays = pkgs.overlays;
      };
in
{
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      # gui stuff
      floorp-bin
      zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      foot
      qt6Packages.qt6ct
      kdePackages.dolphin
      easyeffects
      zathura
      pinnedPkgsForZotero.zotero
      mpv
      fontconfig
      kitty
      qalculate-qt

      gruvbox-plus-icons

      pinnedPkgsForZotero.sunshine
    ]
  );

  services.flatpak.enable = true;

  fonts = {
    enableDefaultPackages = lib.mkDefault true;
    packages = lib.mkAfter (
      with pkgs.nerd-fonts;
      [
        iosevka
        blex-mono
        pkgs.libertinus
      ]
    );
  };
}
