#!/usr/bin/env bash
# ldnf v2.0

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

pkgs_old=$(dnf list --installed | tail -n +2 | cut -d' ' -f1 | cut -d'.' -f1)

dnf$params

pkgs_new=$(dnf list --installed | tail -n +2 | cut -d' ' -f1 | cut -d'.' -f1)
pkgs_diff=$(diff <(echo "$pkgs_old") <(echo "$pkgs_new"))

# > installed packages
pkgs_installed=$(grep '>' <<< "$pkgs_diff" | cut -d' ' -f2)
# < removed packages
pkgs_removed=$(grep '<' <<< "$pkgs_diff" | cut -d' ' -f2)

ldnf_log=/var/log/ldnf.log
# check if $pkgs_installed contains non-whitespace (is empty)
if [[ "$pkgs_installed" = *[![:space:]]* ]]; then
    # create ldnf log if it does not exist
    if [ ! -f "$ldnf_log" ]; then
        mkdir -p "$(dirname $ldnf_log)"
        touch "$ldnf_log"
    fi

    echo -e "\nLDNF packages added to log:"
    for pkg in ${pkgs_installed}; do
        # add packages to log
        echo "$pkg" >> "$ldnf_log"
        echo "  $pkg"
    done
fi

# check if $pkgs_remove contains non-whitespace (is empty)
if [[ "$pkgs_removed" = *[![:space:]]* ]]; then
    echo -e "\nLDNF packages removed from log:"
    for pkg in ${pkgs_removed}; do
        # remove packages from log
        sed -i "/$pkg/d" "$ldnf_log"
        echo "  $pkg"
    done
fi
