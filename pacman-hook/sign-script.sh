#!/bin/bash
path=$(pwd)
linux=($(ls /boot/efi/linux/))
kernel=($(ls /boot/kernel | grep vmlinuz))
function gen_secboot {
        sbctl create-keys &&
        
        for efi in "${linux[@]}"; do
                sbctl sign --save /boot/efi/linux/$efi
        done
        
        sbctl sign --save /boot/EFI/Boot/bootx64.efi &&
        sbctl sign --save /boot/EFI/systemd/systemd-bootx64.efi &&
        
        for vmlinuz in "${kernel[@]}"; do
                sbctl sign --save /boot/kernel/$vmlinuz
        done
        
        cp $path/sbctl-enroll-script.sh /usr/local/bin/ &&
        cp $path/99-sbctl.hook /etc/pacman.d/hooks/ &&
        pacman -Syu sbctl --noconfirm
}
gen_secboot
