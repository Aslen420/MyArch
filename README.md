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
1. // 127.0.0.1  localhost
2. // ::1        localhost
3. // 127.0.1.1  exampleusername
# Second part
1. passwd
2. pacman -S grub efibootmgr
3. mkdir /boot/efi
4. mount /dev/sda1 /boot/efi
5. grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
6. grub-mkconfig -o /boot/grub/grub.cfg
# { Now for the desktop Environment ! }
1. useradd -m aslen
2. passwd aslen
3. pacman -S sudo nano
4. EDITOR=nano visudo
 { under root ALL=(ALL) ALL || (or similar) put this next line }
5. aslen ALL=(ALL) ALL
# { / KDE / }
1. pacman -S xorg plasma plasma-wayland-session kde-applications 
2. systemctl enable sddm.service
3. systemctl enable NetworkManager.service
# { LXQT }
1. sudo pacman -S --needed xorg
2. sudo pacman -S --needed lxqt xdg-utils ttf-freefont sddm
3. sudo pacman -S --needed libpulse libstatgrab libsysstat lm_sensors network-manager-applet oxygen-icons pavucontrol-qt
4. systemctl enable sddm.service
5. systemctl enable NetworkManager.service
# {Now Reboot!}
