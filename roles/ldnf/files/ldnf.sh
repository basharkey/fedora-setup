#!/usr/bin/env bash
# when command fails exit script instead of continuing
set -o errexit
# treat command as failed if one command in a pipline fails
set -o pipefail

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ldnf [dnf options] DNF COMMAND

dnf wrapper that logs installed packages

Examples:
sudo ldnf install pcmanfm
ldnf search feh
'
    exit
fi

for i in $*; do
    params="$params $i"
done

dnf=$(dnf --color=always$params | tee /dev/tty)
echo "$dnf"
pkgs=$(
    # get text between 'Installed:' and 'Complete!'
    awk '/Installed:/,/Complete!/' <<< "$dnf" |
    # remove lines that contain 'Installed:'
    grep --invert-match 'Installed:' |
    # remove lines that contain 'Complete!'
    grep --invert-match 'Complete!' |
    # format package names as lines
    xargs --max-args 1 |
    # remove package version from package name
    awk --field-separator '-[0-9]+.' '{ print $1 }'
)

ldnf_log=/var/log/ldnf.log
logging=false
for pkg in ${pkgs}; do
    if ! grep --quiet --word-regexp "$pkg" "$ldnf_log"; then
        logging=true
    fi
done

if $logging; then
    # create ldnf log if it doesn't exist
    if [ ! -f "$ldnf_log" ]; then
        mkdir -p "$(dirname $ldnf_log)"
        touch "$ldnf_log"
    fi

    echo -e "\nLDNF logging:"
    for pkg in ${pkgs}; do
        if ! grep --quiet --word-regexp "$pkg" "$ldnf_log"; then
            echo "  $pkg"
            echo "$pkg" >> "$ldnf_log"
        fi
    done
fi
