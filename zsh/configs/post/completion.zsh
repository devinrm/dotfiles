# load our own completion functions
fpath=(~/.zsh/completion $(brew --prefix)/share/zsh/site-functions $fpath)

# completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump;
else
  compinit -C;
fi;

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
