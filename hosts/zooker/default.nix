{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../src/editor.nix
    ../../src/pl.nix
    ../../src/aids.nix
    ../../src/nix.nix
    ../../src/cli.nix
    ../../src/niri.nix
    ../../src/gui.nix
    ../../src/kanata.nix
    ../../src/filesystem.nix
  ];
}
