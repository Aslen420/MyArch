echo -e "d\nd\nd\nd\n\n\nw" | fdisk /dev/sda
echo -e "n\np\n1\n\n+1G\nw" | fdisk /dev/sda
echo -e "n\np\n2\n\n\nw" | fdisk /dev/sda
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt
pacstrap /mnt base linux linux-firmware nano neofetch
genfstab -U /mnt >> /mnt/etc/fstab
cat << EOF | arch-chroot /mnt
timedatectl set-timezone Canada/Central
locale-gen
sleep 2
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
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
useradd -m aslen
echo -e "test\ntest" | passwd aslen
yes | pacman -S sudo nano
sed -i '80i aslen ALL=(ALL) ALL' /etc/sudoers
EOF
echo 'Which of the following would you like to install: KDE, lxqt'
read $1
if [[ "$1" == "KDE" ]]; then
    pacman -S xorg plasma plasma-wayland-session kde-applications --noconfirm
    systemctl enable sddm.service
    sleep 2
    systemctl enable NetworkManager.service
    sleep 2
if [[ "$1" == "lxqt" ]]; then
    sudo pacman -S --noconfirm --needed xorg lxqt xdg-utils ttf-freefont sddm libpulse libstatgrab libsysstat lm_sensors network-manager-applet oxygen-icons pavucontrol-qt 
    systemctl enable sddm.service
    systemctl enable NetworkManager.service
else
    echo 'Incorrect Usage. Installing lxqt'
    sudo pacman -S --noconfirm --needed xorg lxqt xdg-utils ttf-freefont sddm libpulse libstatgrab libsysstat lm_sensors network-manager-applet oxygen-icons pavucontrol-qt 
    systemctl enable sddm.service
    systemctl enable NetworkManager.service
fi
fi