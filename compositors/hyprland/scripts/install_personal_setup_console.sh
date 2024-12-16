#!/bin/bash

HYPRLAND_SETUP_PATH=~/exotic-os-setup/compositors/hyprland
OWN_BASE_PATH=$HYPRLAND_SETUP_PATH/dotfiles
CONFIG_PATH=~/.config
ML4W_DOTFILES_PATH=~/dotfiles


# ------------------------------------------------------------------------------------------
echo "Eliminando setup original..."
rm -rf $CONFIG_PATH/ml4w-hyprland-settings 2>/dev/null
rm -rf $ML4W_DOTFILES_PATH 2>/dev/null
mkdir $ML4W_DOTFILES_PATH

# ------------------------------------------------------------------------------------------
echo "Cargando setup personalizado..."

unlink ~/hyprland-setup 2>/dev/null
ln -s $HYPRLAND_SETUP_PATH ~/hyprland-setup

ln -s $OWN_BASE_PATH/dot_bashrc $ML4W_DOTFILES_PATH/.bashrc
ln -s $OWN_BASE_PATH/dot_config $ML4W_DOTFILES_PATH/.config
ln -s $OWN_BASE_PATH/dot_gtkrc-2.0 $ML4W_DOTFILES_PATH/.gtkrc-2.0
ln -s $OWN_BASE_PATH/dot_Xresources $ML4W_DOTFILES_PATH/.Xresources
ln -s $OWN_BASE_PATH/dot_zshrc $ML4W_DOTFILES_PATH/.zshrc

ln -s $OWN_BASE_PATH/config/ml4w-hyprland-settings $CONFIG_PATH/ml4w-hyprland-settings


# -------------------------------------------------------------------------------------------
echo "Modificando comportamiento del boton de apagado, favor reiniciar logind"
sudo sed -i 's/#HandlePowerKey.*/HandlePowerKey=ignore/' /etc/pacman.conf

echo "Setup finalizado!"
