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
    ]
  );
}
