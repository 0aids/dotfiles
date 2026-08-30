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
      # cli tools
      starship
      wget
      btop
      tmux
      ripgrep
      fd
      fzf
      bat
      unzip
      tree
      pciutils
      zip
      file
      tree
      zoxide
      (writeShellScriptBin "copy" ''
                #!/usr/bin/env bash
        		exec dms clipboard copy "$@"
      '')
      (writeShellScriptBin "paste" ''
                #!/usr/bin/env bash
        		exec dms clipboard paste "$@"
      '')
    ]
  );
  documentation.man.enable = true;
  programs.git.enable = true;
}
