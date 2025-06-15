if [[ "$(tty)" =~ ^/dev/tty[1-6]$ ]]; then
  export LC_ALL="en_US.UTF-8"
  export LANGUAGE="en_US.UTF-8"
  export LANG="en_US.UTF-8"
  PS1='%n@%m %3~ %(!.#.$) '
  return
fi

[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
