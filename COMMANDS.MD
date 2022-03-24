# Beginning
1. fdisk /dev/sda     (SDA1 with 1gb // sda2 with the rest of drive)
2. mkfs.fat -F32 /dev/sda1
3. mkfs.ext4 /dev/sda2
4. mount /dev/sda2 /mnt 
5. pacstrap /mnt base linux linux-firmware nano neofetch
6. genfstab -U /mnt >> /mnt/etc/fstab
7. arch-chroot /mnt
8. timedatectl set-timezone Canada/Central
9. locale-gen
10. echo LANG=en_US.UTF-8 > /etc/locale.conf
11. export LANG=en_US.UTF-8
12. echo exampleusername > /etc/hostname
13. touch /etc/hosts
# Edit /etc/hosts to contain the following  
127.0.0.1  localhost
::1        localhost
127.0.1.1  exampleusername
# Second part
passwd
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg\
# { Now for the desktop Environment ! }
useradd -m aslen
passwd aslen
pacman -S sudo nano
EDITOR=nano visudo
{ under root ALL=(ALL) ALL || (or similar) put this next line }
aslen ALL=(ALL) ALL
#{ / KDE / }
pacman -S xorg plasma plasma-wayland-session kde-applications 
systemctl enable sddm.service
systemctl enable NetworkManager.service


# {Now Reboot!}
