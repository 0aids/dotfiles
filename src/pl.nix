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

      elan

      zig
      zig-shell-completions
      zls

      rust-analyzer
      cargo
      rustc

      llvmPackages_23.clang-tools
      llvmPackages_23.clang
      llvmPackages_23.libllvm
      gdb
      rr

      python314Packages.numpy
      python314Packages.pandas
      python314Packages.matplotlib
      python314Packages.scipy
      python314Packages.sympy
      python314Packages.python-lsp-server
      python314Packages.black
    ]
  );
}
