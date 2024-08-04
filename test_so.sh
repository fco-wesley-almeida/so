#/bin/bash

nasm -f bin src/bootloader.asm -o build/bootloader.bin
cd build
dd if=/dev/zero of=boot.img bs=512 count=2880  # Create a 1.44MB floppy image
dd if=bootloader.bin of=boot.img conv=notrunc  # Write the bootloader to the image
qemu-system-x86_64 -drive format=raw,file=boot.img

