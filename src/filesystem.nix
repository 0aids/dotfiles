{
  config,
  pkgs,
  lib,
  ...
}:
{
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/swap".options = [ "noatime" ];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8 * 1024; # Creates an 8GB swap file
    }
  ];

  services.snapper = {
    persistentTimer = true;
    configs.home = {
      SUBVOLUME = "/home";
      ALLOW_USERS = [ "aids" ];
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = 10;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 3;
      TIMELINE_LIMIT_MONTHLY = 1;
      TIMELINE_LIMIT_YEARLY = 0;
    };
  };

}
