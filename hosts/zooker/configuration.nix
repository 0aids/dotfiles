# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./src/editor.nix
    ./src/pl.nix
  ];

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/swap".options = [ "noatime" ];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 8 * 1024; # Creates an 8GB swap file
    }
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "zooker"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  services.automatic-timezoned.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.printing.enable = true;

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

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-kitty";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  environment.systemPackages = with pkgs; [

    # lsp/language stuff
    tinymist
    nixd
    nixfmt

    # gui stuff
    floorp-bin
    foot

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
    (writeShellScriptBin "__kak_fzf_bat_preview" ''
      	      #!/usr/bin/env bash
      	
      	      set -eEuCo pipefail
      	  
      	      declare -r file=$1
      	      declare -i -r line=$2
      	      declare -i -r lines=$LINES
      	  
      	      # subtract 3 for the header
      	      declare -i center=$(( (lines - 3) / 2 ))
      	  
      	      if [ $line -lt $center ]; then
      	          center=$line
      	      fi
      	      declare -i -r start=$(( line - center ))
      	      declare -i -r end=$(( lines + start ))
      	  
                exec bat --color always --highlight-line $line --line-range $start:$end --paging never "$file"
    '')

    (writeShellScriptBin "copy" ''
              #!/usr/bin/env bash
      		exec dms clipboard copy "$@"
    '')
    (writeShellScriptBin "paste" ''
              #!/usr/bin/env bash
      		exec dms clipboard paste "$@"
    '')

    # other tols
    cachix
  ];

  # services.desktopManager.plasma6.enable = true;
  programs.starship.enable = true;
  programs.niri.enable = true;
  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };

  programs.git.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.kanata = {
    enable = true;

    keyboards.default = {
      config = ''
        (defsrc
          caps a s d f j k l scln apos
        )


        (defalias
          ;; tap-hold <tap-timeout> <hold-timeout> <tap-action> <hold-action>
          caps-mod (tap-hold-press 0 200 esc lmet)
          a-mod    (tap-hold-release 0 200 a lalt)
          s-mod    (tap-hold-release 0 200 s lalt)
          d-mod    (tap-hold-release 0 200 d lctl)
          f-mod    (tap-hold-release 0 200 f lsft)
          
          j-mod    (tap-hold-release 0 200 j rsft)
          k-mod    (tap-hold-release 0 200 k rctl)
          l-mod    (tap-hold-release 0 200 l ralt)
          semi-mod (tap-hold-release 0 200 scln ralt)
          apos-mod (tap-hold-release 0 200 apos rmet)
        )

        (deflayer base
          @caps-mod @a-mod @s-mod @d-mod @f-mod @j-mod @k-mod @l-mod @semi-mod @apos-mod
        )
      '';
      # devices = [];
      extraDefCfg = "process-unmapped-keys yes";
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
