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
      vscodium
      vscode
      emacs-pgtk
      kakoune
      kakoune-lsp
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
        	  
                  exec bat --color always --style plain,numbers,header --highlight-line $line --line-range $start:$end --paging never "$file"
      '')
    ]
  );
}
