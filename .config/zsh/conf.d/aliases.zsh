# Disk Usage
alias duh='du -h'
alias dust='du -sh * | sort -hr'

# Editor
alias vi='nvim --clean -i NONE'
alias vim='nvim'
alias svim='sudoedit'

# Find
alias fd='fd --color always'
alias grep='grep -P -i --color=auto'

# File Operations
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -I'
alias dump='rm -rf ${XDG_DATA_HOME}/Trash/*'
alias mkdir='mkdir -p'

# Git
alias g='git'
alias lg='lazygit'

# List
alias ls='eza'
alias ll='ls -l -g --icons=always --long --no-filesize'
alias lla='ll -a'
alias path='echo ${PATH//:/\\n}'

# Rust
alias ru='rustup'
alias cg='cargo'

# System
alias fonts='fc-cache -f -v'
alias restart='systemctl reboot'
alias shutdown='systemctl poweroff'
alias :q='exit'
alias mirror-update="sudo ~/.local/bin/mirror"
