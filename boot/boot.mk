include scripts/common.mk

.PHONY: all
all: $(BUILD_DIR)/gatBoot

$(BUILD_DIR)/boot.o:
	@echo "${fgCYAN_COL}Compiling boot.s${fgDEFAULT_COL}"
	@$(ASM) $(SOURCE_DIR)/boot/boot.s -o $@

$(BUILD_DIR)/kernel.o:
	@echo "${fgCYAN_COL}Compiling kernel.c${fgDEFAULT_COL}"
	@$(CC) $(CFLAGS) -c $(SOURCE_DIR)/boot/kernel.c -o $@

$(BUILD_DIR)/gatBoot: $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o
	@echo "${fgCYAN_COL}Linking gatBoot${fgDEFAULT_COL}"
	@$(LD) -o $@ -T $(SOURCE_DIR)/boot/linker.ld $^