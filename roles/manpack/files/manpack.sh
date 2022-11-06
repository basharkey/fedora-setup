#!/usr/bin/env bash

# when command fails exit script instead of continuing
set -o errexit
# exit when trying to access a variable that has not been set
set -o nounset
# treat command as failed if one command in a pipline fails
set -o pipefail

# run TRACE=1 ./script.sh to enable debug mode
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: manpack.sh dnf|flatpak output-file

Retreives list of dnf|flatpak packages installed by the user and outputs to file

Examples:
manpack.sh dnf /etc/manpack/dnf.txt
manpack.sh flatpak /etc/manpack/flatpak.txt
'
    exit
fi

if [[ $1 == "dnf" ]]; then
	dnf_pkgs_db=$2
	if [ ! -f "$dnf_pkgs_db" ]; then
		mkdir -p "$(dirname $dnf_pkgs_db)"
		touch "$dnf_pkgs_db"
	fi
	
	# list manually installed dnf packages (excludes packages dnf installed using ansible)
	dnf_pkgs=$(ausearch --comm dnf | grep '"install"' | cut -d" " -f 7- | grep --only-matching --perl-regexp '="\K[^"]+')
	
	for p in ${dnf_pkgs}; do
		if ! grep --quiet --word-regexp "$p" "$dnf_pkgs_db"; then
			echo "$p"
			echo "$p" >> "$dnf_pkgs_db"
		fi
	done

elif [[ $1 == "flatpak" ]]; then
	flatpak_pkgs_db=$2
	if [ ! -f "$flatpak_pkgs_db" ]; then
		mkdir -p "$(dirname $flatpak_pkgs_db)"
		touch "$flatpak_pkgs_db"
	fi
	
	flatpak_pkgs=$(ausearch --comm flatpak | grep '"install"' | cut -d" " -f 6- | grep --only-matching --perl-regexp '="\K[^"]+')
	
	for p in ${flatpak_pkgs}; do
		if ! grep --quiet --word-regexp "$p" "$flatpak_pkgs_db"; then
			echo "$p"
			echo "$p" >> "$flatpak_pkgs_db"
		fi
	done
fi
