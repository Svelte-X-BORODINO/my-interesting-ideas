[miska@manjaro ~]$ cat > gentoo_full_auto_mbr_openrc.sh
#!/bin/bash

set -e

echo "🚀 ПОЛНАЯ АВТОМАТИЧЕСКАЯ УСТАНОВКА GENTOO (MBR + OpenRC)"

DISK="/dev/sda"
HOSTNAME="gentoo-box"

# 1) РАЗМЕТКА ДИСКА (MBR)
echo "📀 Разметка диска MBR..."
parted -s $DISK mklabel msdos
parted -s $DISK mkpart primary 1MiB 513MiB
parted -s $DISK set 1 boot on
parted -s $DISK mkpart primary 513MiB 100%

# 2) ФОРМАТИРОВАНИЕ
echo "💾 Форматирование..."
mkfs.ext4 ${DISK}1  # /boot
mkfs.ext4 ${DISK}2  # /

# 3) МОНТИРОВАНИЕ
echo "📂 Монтирование..."
mount ${DISK}2 /mnt/gentoo
mkdir -p /mnt/gentoo/boot
mount ${DISK}1 /mnt/gentoo/boot

# 4) УСТАНОВКА STAGE3 (OpenRC)
echo "📦 Установка Stage3 (OpenRC)..."
cd /mnt/gentoo
STAGE3_URL=$(curl -s https://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt | grep -v '^#' | awk '{print $1}')
wget -q "https://distfiles.gentoo.org/releases/amd64/autobuilds/${STAGE3_URL}"
tar xpf stage3-*.tar.* --xattrs-include='*.*' --numeric-owner

# 5) БАЗОВАЯ КОНФИГУРАЦИЯ
echo "⚙️ Базовая конфигурация..."
# make.conf
cat > etc/portage/make.conf << 'EOF'
CFLAGS="-march=native -O2 -pipe"
CXXFLAGS="${CFLAGS}"
MAKEOPTS="-j$(nproc)"
ACCEPT_LICENSE="*"
EOF

# repos.conf
mkdir -p etc/portage/repos.conf
cp usr/share/portage/config/repos.conf etc/portage/repos.conf/gentoo.conf

# 6) CHROOT И УСТАНОВКА
echo "🔧 Установка в chroot..."

# Копируем DNS и монтируем системы
cp /etc/resolv.conf etc/resolv.conf
mount -t proc /proc proc
mount --rbind /sys sys
mount --make-rslave sys
mount --rbind /dev dev
mount --make-rslave dev

# Chroot и установка
chroot /mnt/gentoo /bin/bash << 'CHROOT_EOF'
set -e

# Синхронизация портажа
echo "🔄 Синхронизация Portage..."
emerge-webrsync || emerge --sync

# Установка бинарного ядра
echo "🐧 Установка gentoo-kernel-bin..."
emerge --quiet-build gentoo-kernel-bin

# Установка системных утилит
echo "📦 Установка системных утилит..."
emerge --quiet-build grub dhcpcd openssh

# Настройка сети
echo "🌐 Настройка сети..."
echo 'config_eth0="dhcp"' > /etc/conf.d/net
cd /etc/init.d
ln -s net.lo net.eth0
rc-update add net.eth0 default

# Настройка SSH
rc-update add sshd default

# Настройка хоста
echo "🏠 Настройка хоста..."
echo "${HOSTNAME}" > /etc/hostname
echo "127.0.0.1 ${HOSTNAME} localhost" > /etc/hosts

# Установка GRUB
echo "🥾 Установка GRUB..."
grub-install ${DISK}
grub-mkconfig -o /boot/grub/grub.cfg

# Создание пользователя
echo "👤 Создание пользователя..."
useradd -m -G wheel,audio -s /bin/bash miska
echo "miska:password" | chpasswd

# Настройка sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

echo "✅ Установка завершена!"
CHROOT_EOF

# 7) ЗАВЕРШЕНИЕ
echo "🎉 УСТАНОВКА ЗАВЕРШЕНА!"
echo "💻 Перезагрузитесь и зайдите под miska/password"
echo "🚀 Добро пожаловать в Gentoo!"

umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
