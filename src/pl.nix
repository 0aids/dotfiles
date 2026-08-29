{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      # lsp/language stuff
      tinymist
      nixd
      nixfmt
    ]
  );
}
