{
  config,
  lib,
  pkgs,
  ...
}:
{
  # coding stuff
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      vim
      emacs
      vscodium
      kakoune
      kakoune-lsp
    ]
  );
}
