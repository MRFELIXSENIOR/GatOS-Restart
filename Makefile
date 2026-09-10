include scripts/common.mk
include kernel/arch/i386/boot.mk

$(BUILD_DIR)/gatOS: ${ASM_OBJECTS} $(BUILD_DIR)/kernel.o
	@echo "Building gatOS"
	@$(LD) -o $@ -T $(KERNEL_DIR)/arch/i386/linker.ld $^

$(BUILD_DIR)/$(OS_IMAGE): $(BUILD_DIR)/gatOS
	@echo "Building $(OS_IMAGE)"
	@$(SCRIPTS_DIR)/make_iso.sh $(BUILD_DIR)/gatOS

.PHONY: clean run all

run: $(BUILD_DIR)/$(OS_IMAGE)
	$(QEMU) $(QEMU_FLAGS)

debug: $(BUILD_DIR)/$(OS_IMAGE)
	$(QEMU) $(QEMU_DFLAGS)

all: $(BUILD_DIR)/$(OS_IMAGE)

clean:
	@echo "Cleaning..."
	@rm -rf $(BUILD_DIR)/*