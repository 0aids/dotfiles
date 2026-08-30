eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash --cmd cd)"
alias nrs="sudo nixos-rebuild switch --flake ~/git/dotfiles/"
alias gs="git status"
alias g="git"
CFG_DIR=$(cd ~/.config/; pwd)
export PATH="$PATH:$CFG_DIR/emacs/bin"
