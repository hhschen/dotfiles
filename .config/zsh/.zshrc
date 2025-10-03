for file in $ZDOTDIR/conf.d/*.zsh; do
  [[ -f "$file" ]] && source "$file"
done
