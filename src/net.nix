{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  users.groups.networkmanager.members = [ "aids" ];

  # Enable firewall by default
  networking.firewall.enable = lib.mkDefault true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

}
