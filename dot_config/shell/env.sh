# Shared shell environment for Bash and Zsh.

case ":${PATH}:" in
  *:"$HOME/.local/bin":*) ;;
  *) PATH="$HOME/.local/bin:$PATH" ;;
esac

if [ -r "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi

if [ -r "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# Respect the system default (set by /etc/profile.d/omarchy.sh -> env-bootstrap
# or the uwsm session). Forcing the ~/.local/share/omarchy symlink path here
# breaks qs ipc instance matching, which does not resolve symlinks.
: "${OMARCHY_PATH:=/usr/share/omarchy}"
export OMARCHY_PATH

case ":${PATH}:" in
  *:"$OMARCHY_PATH/bin":*) ;;
  *) PATH="$OMARCHY_PATH/bin:$PATH" ;;
esac

case ":${PATH}:" in
  *:"$HOME/.local/share/Steam/steamapps/common/Factorio/bin/x64":*) ;;
  *) PATH="$PATH:$HOME/.local/share/Steam/steamapps/common/Factorio/bin/x64" ;;
esac

case ":${PATH}:" in
  *:"$HOME/.lmstudio/bin":*) ;;
  *) PATH="$PATH:$HOME/.lmstudio/bin" ;;
esac

export PATH

export BAT_THEME=ansi
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export SUDO_EDITOR="$EDITOR"
export OPENCODE_ENABLE_EXA=1

export BUN_INSTALL="$HOME/.bun"
case ":${PATH}:" in
  *:"$BUN_INSTALL/bin":*) ;;
  *) PATH="$BUN_INSTALL/bin:$PATH" ;;
esac
export PATH

export NVM_DIR="$HOME/.config/nvm"

if [ -r "$HOME/.config/shell/secrets.sh" ]; then
  . "$HOME/.config/shell/secrets.sh"
fi
