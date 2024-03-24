#!/bin/bash

function format_root() {
    echo "=========================="
    echo "Formatting root partition:"
    echo "=========================="
    echo

    mkfs.ext4 /dev/nvme0n1p5

    echo "[OK]: Press enter to continue..."
    read
    clear
}

format_root
