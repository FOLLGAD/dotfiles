#!/bin/sh

MODE=$1

if [ "$MODE" = day ]; then
	# Day mode
	gsettings set org.gnome.desktop.interface gtk-theme Arc-Darker
	sed -i.bak -e 's/^colors: .*/colors: *light/' $HOME/.config/alacritty/alacritty.yml
else
	# Dark mode (default)
	gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark
	sed -i.bak -e 's/^colors: .*/colors: *dark/' $HOME/.config/alacritty/alacritty.yml
fi
