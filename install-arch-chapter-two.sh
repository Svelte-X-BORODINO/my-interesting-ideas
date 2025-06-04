parted -s /dev/sda mklabel gpt && \
parted -s /dev/sda mkpart primary fat32 1MiB 513MiB && \
parted -s /dev/sda set 1 esp on && \
parted -s /dev/sda mkpart primary ext4 513MiB 100% && \
mkfs.fat -F32 /dev/sda1 && \
mkfs.ext4 /dev/sda2 && \
mount /dev/sda2 /mnt && \
mkdir -p /mnt/boot/efi && \
mount /dev/sda1 /mnt/boot/efi && \
pacstrap /mnt base linux linux-firmware nano grub efibootmgr networkmanager && \
genfstab -U /mnt >> /mnt/etc/fstab && \
arch-chroot /mnt /bin/bash -c "ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
hwclock --systohc && \
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
locale-gen && \
echo 'LANG=en_US.UTF-8' > /etc/locale.conf && \
echo 'arch-sigma' > /etc/hostname && \
passwd && \
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB && \
grub-mkconfig -o /boot/grub/grub.cfg && \
exit" && \
umount -R /mnt && \
echo -e "\n\033[32m[+] Arch Linux установлен! Перезагружайся командой: reboot\033[0m"
