#!/bin/sh
# https://man.sr.ht/~kennylevinsen/greetd/#how-to-set-xdg_session_typewayland

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

# Wayland stuff
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1

# Load user env vars
user_env=$HOME/.config/sway/env
if [ -f "$user_env" ]; then
    source "$user_env"
fi

exec sway $@

#
# If you use systemd and want sway output to go to the journal, use this
# instead of the `exec sway $@` above:
#
#    exec systemd-cat --identifier=sway sway $@
#
