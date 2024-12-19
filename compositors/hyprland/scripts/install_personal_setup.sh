122;6u122;6u#!/bin/bash

# -------------------------------------------------------------------------------------------------------------------------------------------
# dirname archivo -> indica la referencia desde mi posicion actual a la ruta de la carpeta padre de un archivo x
# readlink -f archivo -> indica la ruta completa de un archivo dado su nombre
# $0 -> referencia al nombre del archivo actual, parametro por defecto
# -------------------------------------------------------------------------------------------------------------------------------------------

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
ln -s $OWN_BASE_PATH/ml4w-hyprland-settings $ML4W_DOTFILES_PATH/ml4w-hyprland-settings
ln -s $ML4W_DOTFILES_PATH/ml4w-hyprland-settings $CONFIG_PATH/ml4w-hyprland-settings
# -------------------------------------------------------------------------------------------

if pgrep -i "hyprland" > /dev/null; then
	echo "Recargando UI..."
	$ML4W_DOTFILES_PATH/waybar/launch.sh
	hyprpm reload -n
	hyprctl reload
else
    echo "Hyprland no activo, recarga de UI omitida!"
fi

echo "Cargando plugins..."
hyprpm update
hyprpm enable hyprexpo


echo "Modificando comportamiento del boton de apagado, favor reiniciar logind"
sudo sed -i 's/#HandlePowerKey.*/HandlePowerKey=ignore/' /etc/pacman.conf

echo "Setup finalizado!"
