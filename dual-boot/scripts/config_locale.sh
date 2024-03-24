#!/bin/bash

function configure_locale() {
    echo "==================="
    echo "Configuring locale:"
    echo "==================="
    echo

    sed -i "s/#en_IN UTF-8/en_IN UTF-8/" /etc/locale.gen
    locale-gen
    echo "LANG=en_IN.UTF-8" >> /etc/locale.conf

    echo "[OK]: Press enter to continue..."
    read
    clear
}

configure_locale
