# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# f35 sway issue with nouveau (fixes gray screen with artifacts)
export WLR_DRM_NO_MODIFIERS=1

# set qt theme to currently selected theme in qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

# ssh agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# User specific environment and startup programs
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec sway
fi

# enables ctrl-s to reverse search for interactive shell
[[ $- == *i* ]] && stty -ixon
