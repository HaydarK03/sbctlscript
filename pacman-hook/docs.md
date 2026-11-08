
## presetup

1. masuk ke bios
2. masuk ke setup mode secureboot
3. booting ke linux

## setup


cari partisi boot windows

```
lsblk
```

mounting partisi windows

```
mount /dev/[partisi boot windows] /mnt
```

copy folder /EFI/Microsoft ke /boot/EFI/

```
cp -r /mnt/Microsoft /boot/EFI
```

buatn entries

```
vim /boot/loader/entries/windows.conf
```

```
title   Windows 11
efi     /EFI/Microsoft/Boot/bootmgfw.efi
```


jalankan script sbctl

```
git clone https://github.com/haydark03/sbctlscript.git
```

```
cd sbctlscript/pacman-hook
```

```
chmod +x sign-script.sh
```

```
./sign-script.sh
```


