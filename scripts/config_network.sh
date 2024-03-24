#!/bin/bash

function configure_network() {
    echo "===================="
    echo "Configuring network:"
    echo "===================="
    echo

    echo "Please enter your hostname:"
    read HOSTNAME
    echo $HOSTNAME >> /etc/hostname

    echo "# The following lines are desirable for IPv4 capable hosts" >> /etc/hosts
    echo "127.0.0.1       localhost"                                  >> /etc/hosts
    echo "# 127.0.1.1 is often used for the FQDN of the machine"      >> /etc/hosts
    echo "127.0.1.1       ${HOSTNAME}"                                >> /etc/hosts
    echo "# The following lines are desirable for IPv6 capable hosts" >> /etc/hosts
    echo "::1             localhost ip6-localhost ip6-loopback"       >> /etc/hosts
    echo "ff02::1         ip6-allnodes"                               >> /etc/hosts
    echo "ff02::2         ip6-allrouters"                             >> /etc/hosts

    systemctl enable NetworkManager

    echo "[OK]: Press enter to continue..."
    read
    clear
}

configure_network
