autoload -Uz vcs_info
precmd() { vcs_info }
setopt PROMPT_SUBST
NEWLINE=$'\n'
PS1='%m: %F{cyan}%3~%f %F{yellow}${vcs_info_msg_0_}%f ${NEWLINE}%F{green}$%f '

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '→ %b %u%c'
zstyle ':vcs_info:git:*' actionformats '→ %b | %a%u%c'
