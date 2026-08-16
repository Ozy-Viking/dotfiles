# Zsh-specific interactive setup.

[[ -n ${ZSH_VERSION:-} ]] || return

HISTFILE="$HOME/.zsh_history"
HISTSIZE=32768
SAVEHIST=32768

setopt append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt interactive_comments
setopt auto_cd
unsetopt beep
unsetopt nomatch

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' group-name ''
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' switch-group '<' '>'

if [[ -r /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
elif [[ -r /usr/share/zsh/plugins/fzf-tab/fzf-tab.zsh ]]; then
  source /usr/share/zsh/plugins/fzf-tab/fzf-tab.zsh
fi

bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[[C' forward-char
bindkey '^[[D' backward-char

if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
elif [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  . "$NVM_DIR/nvm.sh"
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if [[ ${TERM:-} != "dumb" ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v try >/dev/null 2>&1; then
  try() {
    unset -f try
    eval "$(SHELL=/bin/zsh command try init ~/Work/tries)"
    try "$@"
  }
fi

if [[ -t 0 && -t 1 ]] && command -v fzf >/dev/null 2>&1; then
  if [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
  fi
  if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  fi
fi

if command -v opencode >/dev/null 2>&1; then
  source <(SHELL=/usr/bin/zsh opencode completion)
  compdef _opencode_yargs_completions c 2>/dev/null || true
fi

if command -v atuin >/dev/null 2>&1; then
  source <(atuin gen-completions --shell zsh)
fi

if [[ -t 0 && -t 1 ]] && command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

if command -v dns >/dev/null 2>&1; then
  source <(dns completions zsh)
fi

if command -v typst >/dev/null 2>&1; then
  source <(typst completions zsh)
fi

if command -v chezmoi >/dev/null 2>&1; then
  source <(chezmoi completion zsh)
fi
if command -v diesel >/dev/null 2>&1; then
  source <(diesel completions zsh)
fi

if command -v rustup >/dev/null 2>&1; then
  source <(rustup completions zsh rustup)
fi

_omarchy() {
  emulate -L zsh
  local cur prefix omarchy_path bin_dir file basename rest next args enum
  local -a candidates
  local -A seen

  cur="${words[CURRENT]}"
  omarchy_path=$(command -v omarchy 2>/dev/null) || return 0
  bin_dir=$(dirname -- "$(readlink -f -- "$omarchy_path" 2>/dev/null || printf '%s' "$omarchy_path")")
  [[ -d $bin_dir ]] || return 0

  prefix="omarchy"
  local i part
  for (( i = 2; i < CURRENT; i++ )); do
    part="${words[i]}"
    [[ -z $part || $part == -* ]] && continue
    prefix+="-$part"
  done

  for file in "$bin_dir/$prefix"-*(N); do
    [[ -f $file && -x $file ]] || continue
    basename="${file:t}"
    rest="${basename#"$prefix"-}"
    next="${rest%%-*}"
    if [[ -n $next && -z ${seen[$next]:-} ]]; then
      seen[$next]=1
      candidates+=("$next")
    fi
  done

  if (( CURRENT == 2 )); then
    candidates+=(commands)
  fi

  if [[ ${words[2]:-} == commands && CURRENT -ge 3 ]]; then
    candidates+=(--all --json --markdown --check)
  fi

  if (( ${#candidates[@]} == 0 )) && [[ -x $bin_dir/$prefix ]]; then
    args=$(grep -m 1 '^# omarchy:args=<' "$bin_dir/$prefix" 2>/dev/null)
    enum="${args#*<}"
    enum="${enum%%>*}"

    if [[ $enum == *"|"* && $enum != *" "* ]]; then
      candidates=(${(s:|:)enum})
    fi
  fi

  (( ${#candidates[@]} > 0 )) && _describe 'omarchy command' candidates
}

compdef _omarchy omarchy

if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
