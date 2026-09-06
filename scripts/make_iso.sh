set -e

BOOT_BINARY=$1

if grub-file --is-x86-multiboot $BOOT_BINARY; then
  echo Multiboot Available
else
  echo Multiboot Not Available
  exit
fi

cp $BOOT_BINARY isodir/boot/gatOS
grub-mkrescue -o build/gatOS.iso isodir