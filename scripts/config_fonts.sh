#!/bin/bash

function configure_fonts() {
    echo "=================="
    echo "Configuring fonts:"
    echo "=================="
    echo

    mkdir -p /usr/local/share/fonts
    tar -xzf ./misc -C /usr/share/local/fonts/
    mkdir ~/.config/fontconfig
    cp ./misc/fonts.conf ~/.config/fontconfig/
    fc-cache --force

    echo "[OK]: Press enter to continue..."
    read
    clear
}

configure_fonts
