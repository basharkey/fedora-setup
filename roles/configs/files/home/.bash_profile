# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set qt theme to currently selected theme in qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

# fixes mouse cursor disappearing when moving between windows in swaywm
export WLR_NO_HARDWARE_CURSORS=1

# ssh agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# User specific environment and startup programs
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    # fixes flatpak java apps showing blank window
    #_JAVA_AWT_WM_NONREPARENTING=1 sway
    exec sway
fi

# enables ctrl-s to reverse search for interactive shell
[[ $- == *i* ]] && stty -ixon
