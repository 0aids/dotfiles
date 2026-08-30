{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Make boot quieter so it doesnt hide plymouth
  boot.kernelParams = lib.mkDefault [
    "quiet"
    "splash"
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.plymouth = {
    enable = true;
    themePackages = with pkgs; [
      plymouth-blahaj-theme
    ];
    theme = "blahaj";
  };
}
