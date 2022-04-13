echo -e "d\nd\nd\nd\n\n\nw" | fdisk /dev/vda
echo -e "n\np\n1\n\n+1G\nw" | fdisk /dev/vda
echo -e "n\np\n2\n\n\nw" | fdisk /dev/vda
mkfs.fat -F32 /dev/vda1
mkfs.ext4 /dev/vda2
mount /dev/vda2 /mnt
reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base linux linux-firmware nano neofetch
genfstab -U /mnt >> /mnt/etc/fstab
cat << EOF | arch-chroot /mnt
timedatectl set-timezone Canada/Central
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo aslen-pc > /etc/hostname
touch /etc/hosts
echo "127.0.0.1     localhost" > /etc/hosts
echo "::1           localhost" >> /etc/hosts
echo "127.0.1.1     aslen-pc" >> /etc/hosts
echo -e "test\ntest" | passwd root
yes | pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/vda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
useradd -m aslen
echo -e "test\ntest" | passwd aslen
yes | pacman -S sudo nano
sed -i '80i aslen ALL=(ALL) ALL' /etc/sudoers
pacman -S --noconfirm xorg-xinit xorg git base-devel
cd /usr/src
git clone git://git.suckless.org/dwm
git clone git://git.suckless.org/st
git clone git://git.suckless.org/dmenu
cd dwm
make clean install
cd st
make clean install
cd dmenu
make clean install
echo 'Login as a user, then type 'nano ~/.xinitrc' and add "exec dwm" to it'
EOF
