# Bash-specific interactive setup.

[[ -n ${BASH_VERSION:-} ]] || return

shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

if [[ ! -v BASH_COMPLETION_VERSINFO && -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
fi

set +h

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  . "$NVM_DIR/nvm.sh"
fi

if [[ -s "$NVM_DIR/bash_completion" ]]; then
  . "$NVM_DIR/bash_completion"
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

if [[ $- == *i* ]] && [[ ${TERM:-} != "dumb" ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

if command -v try >/dev/null 2>&1; then
  try() {
    unset -f try
    eval "$(SHELL=/bin/bash command try init ~/Work/tries)"
    try "$@"
  }
fi

if [[ -t 0 && -t 1 ]] && command -v fzf >/dev/null 2>&1; then
  if [[ -f /usr/share/fzf/completion.bash ]]; then
    source /usr/share/fzf/completion.bash
  fi
  if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
    source /usr/share/fzf/key-bindings.bash
  fi
fi

if [[ -f "$OMARCHY_PATH/default/bash/completions" ]]; then
  source "$OMARCHY_PATH/default/bash/completions"
fi

for file in "$HOME"/.config/bash/completions/*; do
  [[ -r $file ]] && source "$file"
done

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

if [[ -t 0 && -t 1 ]] && command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash)"
fi

if [[ $- == *i* ]] && command -v dns >/dev/null 2>&1; then
  complete -r dns 2>/dev/null || true
  source <(dns completions bash)
fi

if [[ $- == *i* && -f "$OMARCHY_PATH/default/bash/inputrc" ]]; then
  bind -f "$OMARCHY_PATH/default/bash/inputrc"
fi

_t3_bootstrap_completion() {
  local completion_script
  completion_script="$(bunx t3@latest --completions bash)" || return
  eval "$completion_script"
  _t3
}

complete -F _t3_bootstrap_completion t3
