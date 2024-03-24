#!/bin/bash

function configure_users() {
    echo "=================="
    echo "Configuring users:"
    echo "=================="
    echo

    pacman -S sudo

    echo "Please enter new root password:"
    passwd
    echo

    echo "Please enter a username:"
    read USERNAME
    useradd -m $USERNAME
    echo

    echo "Please enter a password for new user:"
    passwd $USERNAME
    echo

    sed -i "s/root ALL=(ALL:ALL) ALL/root ALL=(ALL:ALL) ALL\n${USERNAME} ALL=(ALL:ALL) ALL/" /etc/sudoers

    echo "[OK]: Press enter to continue..."
    read
    clear
}

configure_users
