
Debian
====================
This directory contains files used to package Krond/Kron-qt
for Debian-based Linux systems. If you compile Krond/Kron-qt yourself, there are some useful files here.

## Kron: URI support ##


Kron-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install Kron-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your Kron-qt binary to `/usr/bin`
and the `../../share/pixmaps/Kron128.png` to `/usr/share/pixmaps`

Kron-qt.protocol (KDE)

