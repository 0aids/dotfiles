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
}
