#!/bin/sh

# setup locale
sed -i "s/#en_IN UTF-8/en_IN UTF-8/" /etc/locale.gen
locale-gen
echo "LANG=en_IN.UTF-8" >> /etc/locale.conf

# setup host name
echo "coffee" >> /etc/hostname

# pacman configuration
sed -i "s/#Color/Color/" /etc/pacman.conf
sed -i "s/#ParallelDownloads = 5/ParallelDownloads = 5/" /etc/pacman.conf

# mount the efi partition to /boot/efi
mount /dev/nvme0n1p1 /boot/efi --mkdir

# install and setup grub
yes | pacman -S grub efibootmgr os-prober
sed -i "s/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Grub
grub-mkconfig -o /boot/grub/grub.cfg

# set root password
yes "root" | passwd

# install sudo package
yes | pacman -S sudo

# setup a new user
useradd -m birb
yes "birb" | passwd birb
sed -i "s/root ALL=(ALL:ALL) ALL/root ALL=(ALL:ALL) ALL\nbirb ALL=(ALL:ALL) ALL/" /etc/sudoers

# enable networkmanager
systemctl enable NetworkManager

