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
    ../../src/boot.nix
    ../../src/printing.nix
    ../../src/net.nix
    ../../src/time.nix
    ../../src/sec.nix
  ];
  networking.firewall.trustedInterfaces = [ "wlp0s20f0u3" ];
}
