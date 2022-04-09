mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt
pacstrap /mnt base linux linux-firmware nano neofetch
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
timedatectl set-timezone Canada/Central
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo aslen-pc > /etc/hostname
touch /etc/hosts
echo "127.0.0.1     localhost" > ~/.test.txt
echo "::1           localhost" >> ~/.test.txt
echo "127.0.1.1     aslen-pc" >> ~/.test.txt
passwd
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
useradd -m aslen
passwd aslen
pacman -S sudo nano
EDITOR=nano visudo
sudo pacman -S --needed xorg
sudo pacman -S --needed lxqt xdg-utils ttf-freefont sddm
sudo pacman -S --needed libpulse libstatgrab libsysstat lm_sensors network-manager-applet oxygen-icons pavucontrol-qt
systemctl enable sddm.service
systemctl enable NetworkManager.service
