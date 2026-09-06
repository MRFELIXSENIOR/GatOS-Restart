export OS_IMAGE		= gatOS.iso

export QEMU			= qemu-system-i386.exe
export QEMU_FLAG	= -drive file=$(BUILD_DIR)/$(OS_IMAGE),format=raw

export CFLAGS 		= -std=c99 -ffreestanding -O2 -Wall -Wextra -I$(SOURCE_DIR) -L$(LIB_DIR)
export ASM			= i686-elf-as.exe
export CC			= i686-elf-gcc.exe
export CXX			= i686-elf-g++.exe
export LD			= i686-elf-ld.exe
export AR			= i686-elf-ar.exe

export SOURCE_DIR 	= .
export LIB_DIR 		= lib
export BUILD_DIR 	= build