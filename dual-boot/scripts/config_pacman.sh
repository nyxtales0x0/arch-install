#!/bin/bash

function configure_pacman() {
    echo "==================="
    echo "Configuring pacman:"
    echo "==================="
    echo

    PACMAN_CONFIG="/etc/pacman.conf"
    sed -i "s/#Color/Color/" $PACMAN_CONFIG
    sed -i "s/#ParallelDownloads/ParallelDownloads/" $PACMAN_CONFIG

    echo "[OK]: Press enter to continue..."
    read
    clear
}

configure_pacman
