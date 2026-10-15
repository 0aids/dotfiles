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
      cachix
      usbutils
      # cli tools
      starship
      wget
      btop
      tmux
      ripgrep
      pdfgrep
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
      lazygit
      nix-direnv
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
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
