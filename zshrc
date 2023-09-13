set -o emacs

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# add bin and local/bin to path
[ -d "/usr/local/bin" ] && PATH="/usr/local/bin:${PATH}"
[ -d "${HOME}/bin" ] && PATH="${HOME}/bin:${PATH}"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob \!.git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_fzf_compgen_path() {
  rg --files "$1" | with-dir "$1"
}

# Use rg to generate the list for directory completion
_fzf_compgen_dir() {
  rg --files "$1" | only-dir "$1"
}

export FZF_DEFAULT_OPTS='
  --color=dark
'

# syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Hub
eval "$(hub alias -s)"

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
. "$HOME/.cargo/env"

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/plugins/golang/set-env.zsh
fpath=(${ASDF_DIR}/completions $fpath)
export NODEJS_CHECK_SIGNATURES=no


# docker
export COMPOSE_HTTP_TIMEOUT=300

# keychain
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  /usr/bin/keychain --nogui $HOME/.ssh/id_rsa
  source $HOME/.keychain/MSI-sh
fi

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
