OS=WSL

include scripts/common.mk

all: $(BUILD_DIR)/$(OS_IMAGE)

run: $(BUILD_DIR)/$(OS_IMAGE)
	$(QEMU) $(QEMU_FLAG)

$(BUILD_DIR)/gatBoot:
	@echo "${fgCYAN_COL}Building gatBoot${fgDEFAULT_COL}"
	@$(MAKE) -f $(SOURCE_DIR)/boot/boot.mk

$(BUILD_DIR)/$(OS_IMAGE): $(BUILD_DIR)/gatBoot
	@echo "${fgCYAN_COL}Building $(OS_IMAGE)${fgDEFAULT_COL}"
	@$(SOURCE_DIR)/scripts/make_iso.sh $(BUILD_DIR)/gatBoot

.PHONY: clean run all
clean:
	@echo "${fgCYAN_COL}Cleaning..."
	@rm -rf $(BUILD_DIR)/*