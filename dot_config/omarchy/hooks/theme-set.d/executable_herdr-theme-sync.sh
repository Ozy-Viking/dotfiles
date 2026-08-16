#!/bin/bash
# Sync the herdr terminal theme with the active Omarchy theme.
# Runs on every `omarchy theme set` (theme slug in $1).

set -euo pipefail

CONFIG_FILE="$HOME/.config/herdr/config.toml"
PALETTE="$HOME/.local/state/omarchy/current/theme/colors.toml"
THEME_SLUG="${1:-}"
[[ -n $THEME_SLUG ]] || THEME_SLUG=$(cat "$HOME/.local/state/omarchy/current/theme.name" 2>/dev/null || true)

[[ -f $CONFIG_FILE ]] || exit 0

case "$THEME_SLUG" in
  tokyo-night) HERDR_THEME="tokyo-night" ;;
  catppuccin) HERDR_THEME="catppuccin" ;;
  catppuccin-latte) HERDR_THEME="catppuccin-latte" ;;
  nord) HERDR_THEME="nord" ;;
  gruvbox) HERDR_THEME="gruvbox" ;;
  kanagawa) HERDR_THEME="kanagawa" ;;
  rose-pine) HERDR_THEME="rose-pine" ;;
  white|flexoki-light) HERDR_THEME="one-light" ;;
  hackerman) HERDR_THEME="terminal" ;;
  *) HERDR_THEME="catppuccin" ;;
esac

python3 - "$CONFIG_FILE" "$HERDR_THEME" "$PALETTE" <<'PY'
import re
import sys

path, theme, palette = sys.argv[1], sys.argv[2], sys.argv[3]

colors = {}
try:
    with open(palette) as f:
        for line in f:
            m = re.match(r"^([a-z_]+)\s*=\s*\"#([0-9a-fA-F]{6})\"", line)
            if m:
                colors[m.group(1)] = m.group(2)
except OSError:
    pass

# omarchy color key -> herdr custom token
# NOTE: herdr uses overlay0/overlay1/subtext0 for text in places, so those are
# left to the base theme to keep text readable. Only override backgrounds,
# the accent, and the rainbow status colors.
tokens = {
    "accent": "accent",
    "red": "red",
    "green": "green",
    "yellow": "yellow",
    "blue": "blue",
    "cyan": "teal",
    "magenta": "mauve",
    "orange": "peach",
    "background": "panel_bg",
    "lighter_background": "surface0",
    "dark_background": "surface1",
    "darker_background": "surface_dim",
    "foreground": "text",
}

with open(path) as f:
    lines = f.readlines()

# Drop any existing real [theme.custom] block (commented examples are left alone).
res, skip = [], False
for line in lines:
    if re.match(r"^\s*\[theme\.custom\]\s*$", line):
        skip = True
        continue
    if skip:
        if re.match(r"^\s*\[", line):
            skip = False
        else:
            continue
    res.append(line)

out, in_theme, name_done = [], False, False
for line in res:
    if re.match(r"^\s*\[theme\]\s*$", line):
        in_theme = True
        out.append(line)
        continue
    if in_theme and re.match(r"^\s*\[", line):
        in_theme = False
    if in_theme and not name_done and re.match(r'^\s*name\s*=\s*".*"', line):
        line = re.sub(r'(^\s*name\s*=\s*")[^"]*(".*)$', r"\g<1>" + theme + r"\g<2>", line)
        name_done = True
        out.append(line)
        out.append("\n[theme.custom]\n")
        for src, dst in tokens.items():
            if src in colors:
                out.append(f'{dst} = "#{colors[src]}"\n')
        continue
    out.append(line)

with open(path, "w") as f:
    f.writelines(out)
PY

# Best-effort: reload the running herdr server, if any.
if [[ -S $HOME/.config/herdr/herdr.sock ]]; then
  herdr server reload-config >/dev/null 2>&1 || true
fi
