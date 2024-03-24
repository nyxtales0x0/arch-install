#!/bin/bash

function configure_timezone() {
    echo "====================="
    echo "Configuring timezone:"
    echo "====================="
    echo

    ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
    hwclock --systohc

    echo "[OK]: Press enter to continue..."
    read
    clear
}

configure_timezone
