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
}
gen_secboot
