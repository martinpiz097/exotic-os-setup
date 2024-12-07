#!/bin/bash

OWN_BASE_PATH=~/manjaro-personal-setup/compositors/hyprland/dotfiles
CONFIG_PATH=~/.config
DOTFILES_CONFIG_PATH=~/dotfiles/.config

echo "Deshabilitando configuraciones existentes..."
if ! unlink "$DOTFILES_CONFIG_PATH/hypr/conf/custom.conf" 2>/dev/null; then
    rm "$DOTFILES_CONFIG_PATH/hypr/conf/custom.conf" 2>/dev/null
fi

if ! unlink "$CONFIG_PATH/ml4w-hyprland-settings/hyprctl.json" 2>/dev/null; then
    rm "$CONFIG_PATH/ml4w-hyprland-settings/hyprctl.json" 2>/dev/null
fi

if ! unlink "$DOTFILES_CONFIG_PATH/waybar/modules.json" 2>/dev/null; then
    rm "$DOTFILES_CONFIG_PATH/waybar/modules.json" 2>/dev/null
fi

if ! unlink "$DOTFILES_CONFIG_PATH/hypr/hyprshade.toml" 2>/dev/null; then
    rm "$DOTFILES_CONFIG_PATH/hypr/hyprshade.toml" 2>/dev/null
fi



echo "Ajustando configuraciones personales..."
ln -s  $OWN_BASE_PATH/hypr/conf/custom.conf $DOTFILES_CONFIG_PATH/hypr/conf/custom.conf
ln -s  $OWN_BASE_PATH/ml4w-hyprland-settings/hyprctl.json $CONFIG_PATH/ml4w-hyprland-settings/hyprctl.json
ln -s  $OWN_BASE_PATH/waybar/modules.json $DOTFILES_CONFIG_PATH/waybar/modules.json
ln -s  $OWN_BASE_PATH/hypr/hyprshade.toml $DOTFILES_CONFIG_PATH/hypr/hyprshade.toml


echo "Setup finalizado! Recargando UI..."
$DOTFILES_CONFIG_PATH/waybar/launch.sh
hyprctl reload
