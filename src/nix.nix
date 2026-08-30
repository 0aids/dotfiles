{
  config,
  lib,
  pkgs,
  ...
}:
{
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nix.optimise.automatic =  true;
  nix.gc.automatic = true;
  programs.nix-ld.enable = true;
}
