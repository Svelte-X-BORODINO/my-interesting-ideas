#!/bin/bash

cfdisk /dev/sda;mkfs.ext4 /dev/sda1; mount /dev/sda1 /mnt; pacstrap /mnt base linux linux-firmware git links gcc clang docker ansible make vim nano sudo mc fastfetch btop htop npm nodejs networkmanager; genfstab -U /mnt >> /mnt/etc/fstab; arch-chroot /mnt bash -c "useradd -mG wheel miska; echo '%wheel ALL=(ALL ALL) ALL' >> /etc/sudoers; echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen; locale-gen; echo 'LANG=en_US.UTF-8' > /etc/locale.conf; pacman -S grub; grub-install /dev/sda --target=i386-pc; grub-mkconfig -o /boot/grub/grub.cfg; exit"; reboot
