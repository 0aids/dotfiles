alias nrs="sudo nixos-rebuild switch --flake ~/git/dotfiles/"
alias gs="git status"
export PATH="$PATH:$(cd ~/.config/; pwd)/emacs/bin"

eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash --cmd cd)"

function open() {
    nohup xdg-open "$*" > /dev/null 2>&1 & disown
}
