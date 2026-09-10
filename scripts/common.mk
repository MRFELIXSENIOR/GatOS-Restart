export OS_IMAGE		= 	gatOS.iso

export QEMU			= 	qemu-system-i386.exe
export QEMU_FLAGS	= 	-drive file=$(BUILD_DIR)/$(OS_IMAGE),format=raw
export QEMU_DFLAGS	=	$(QEMU_FLAGS) -d int,cpu_reset -no-reboot

export CFLAGS 		= 	-std=c11 -ffreestanding -O2 -Wall -Wextra $(addprefix -I,$(INCLUDE_DIR))
export AR_FLAGS		= 	-rvs
export ASM_FLAGS	=	-felf32
export ASM			= 	nasm
export CC			= 	i686-elf-gcc
export CXX			= 	i686-elf-g++
export LD			= 	i686-elf-ld
export AR			= 	i686-elf-ar

export SOURCE_DIR 	= 	.
export INCLUDE_DIR 	=	\
	$(SOURCE_DIR)/include\
	$(SOURCE_DIR)/kernel/include\

export LIB_DIR 		= 	$(SOURCE_DIR)/lib
export BUILD_DIR 	= 	$(SOURCE_DIR)/build
export KERNEL_DIR 	= 	$(SOURCE_DIR)/kernel
export SCRIPTS_DIR 	=	$(SOURCE_DIR)/scripts