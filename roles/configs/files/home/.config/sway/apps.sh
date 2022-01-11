#!/bin/bash
swaymsg "workspace 8"
swaymsg "exec keepassxc"
sleep 2

swaymsg "workspace 7"
swaymsg "exec evolution"
swaymsg "exec flatpak run io.freetubeapp.FreeTube --disable-gpu"
sleep 4

swaymsg "workspace 5"
swaymsg "exec firefox-wayland"
swaymsg "exec flatpak run com.discordapp.Discord --disable-gpu"
