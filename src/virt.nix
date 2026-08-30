{
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.libvirtd.enable = true;
  systemd.services.virt-secret-init-encryption.enable = false;
  programs.virt-manager.enable = true;
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      dnsmasq
    ]
  );
}
