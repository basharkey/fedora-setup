#!/usr/bin/env bash

exec_option () {
    # exec arguments except for last which is changed for $option
    echo "exec: $all_args_except_last $1"
    $all_args_except_last $1
    echo "$1" > "$cache_file"
    echo "$1" | festival --tts
}

all_args_except_last=${@:1:$#-1}
last_arg=${@:$#}

cache_file="$HOME/.cache/toggle/$@"

# split last arg into array
IFS=' ' read -a options <<< "$last_arg"

# if cache file doesn't exit
if [[ ! -f "$cache_file" ]]; then
    mkdir -p "$(dirname "$cache_file")"
    # set $current_option to last option so it flips back to first option
    current_option="${options[@]: -1:1}"
# else set to $current_option to $cache_file value
else
    current_option=$(cat "$cache_file")
fi

next_option=false
for option in "${options[@]}"; do
    if [[ $next_option = true ]]; then
        exec_option "$option"
        exit
    fi

    if [[ "$option" = "$current_option" ]]; then
        if [[ "$option" = "${options[@]: -1:1}" ]]; then
            exec_option "${options[0]}"
            exit
        fi
        next_option=true
    fi
done
