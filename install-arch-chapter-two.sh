pacman -Sy archlinux-keyring && \
loadkeys ru && \
timedatectl set-ntp true && \
(echo "g;n;1;;+1G;t;1;n;2;;;w;" | fdisk /dev/sda) && \
mkfs.fat -F32 /dev/sda1 && \
mkfs.ext4 /dev/sda2 && \
mount /dev/sda2 /mnt && \
mkdir /mnt/boot && \
mount /dev/sda1 /mnt/boot && \
pacstrap /mnt base linux linux-firmware nano grub && \
genfstab -U /mnt >> /mnt/etc/fstab && \
arch-chroot /mnt bash -c "ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
hwclock --systohc && \
echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && \
locale-gen && \
echo 'LANG=en_US.UTF-8' > /etc/locale.conf && \
echo 'KEYMAP=ru' > /etc/vconsole.conf && \
echo 'arch' > /etc/hostname && \
echo '127.0.0.1 localhost' >> /etc/hosts && \
echo '::1 localhost' >> /etc/hosts && \
echo '127.0.1.1 arch.localdomain arch' >> /etc/hosts && \
useradd -mG wheel -s /bin/bash miksa
passwd miksa && \
grub-install /dev/sda && \
grub-mkconfig -o /boot/grub/grub.cfg && \
systemctl enable dhcpcd && \
exit" && \
umount -R /mnt && \
reboot
