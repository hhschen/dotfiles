# fzf
source <(fzf --zsh)

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

_fzf_compgen_path() { rg --files --glob "!.git" "$1" }

_fzf_compgen_dir() { fd --type d --hidden --follow --exclude ".git" "$1" }

# zoxide
eval "$(zoxide init zsh)"

# Load some function
fpath=($ZDOTDIR/functions/ $fpath)
autoload -Uz $ZDOTDIR/functions/*(:t)
