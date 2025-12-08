#!/bin/bash
linux=($(ls /boot/efi/linux/))
kernel=($(ls /boot/kernel | grep vmlinuz))
function gen_secboot {
        sbctl create-keys &&
        for efi in "${linux[@]}"; do
                sbctl sign --save /boot/efi/linux/$efi
        done &&
        sbctl sign --save /boot/EFI/Boot/bootx64.efi &&
        sbctl sign --save /boot/EFI/systemd/systemd-bootx64.efi &&
        for vmlinuz in "${kernel[@]}"; do
                sbctl sign --save /boot/kernel/$vmlinuz
        done &&
        cp ~/sbctl-enroll-script.sh /usr/local/bin/ &&
        cp ~/sbctl-sign.service /etc/systemd/system/
        sudo systemctl daemon-reload &&
        sudo systemctl enable sbctl-sign &&
        sudo systemctl start sbctl-sign &&
        systemctl reboot --firmware-setup
}
gen_secboot
