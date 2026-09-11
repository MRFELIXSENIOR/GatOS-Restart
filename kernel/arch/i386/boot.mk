include scripts/common.mk

ASM_SOURCES = $(wildcard $(KERNEL_DIR)/arch/i386/*.asm)
ASM_OBJECTS = $(patsubst %.asm,$(BUILD_DIR)/%.o,$(ASM_SOURCES))

BOOT_C_SOURCES 	= $(wildcard $(KERNEL_DIR)/arch/i386/*.c)
BOOT_C_OBJECTS	= $(patsubst %.c,$(BUILD_DIR)/%.o,$(BOOT_C_SOURCES))

C_SOURCES 	= $(wildcard $(KERNEL_DIR)/kernel/*.c)
C_OBJECTS	= $(patsubst %.c,$(BUILD_DIR)/%.o,$(C_SOURCES))

OBJECTS = $(BOOT_C_OBJECTS) $(C_OBJECTS) $(ASM_OBJECTS)

.PHONY: all
all: $(OBJECTS)

$(BUILD_DIR)/%.o: %.asm
	@echo "Compiling $<"
	@mkdir -p $(@D)
	@$(ASM) $(ASM_FLAGS) $< -o $@

$(BUILD_DIR)/$(KERNEL_DIR)/arch/i386/%.o: $(KERNEL_DIR)/arch/i386/%.c
	@echo "Compiling $<"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/$(KERNEL_DIR)/kernel/%.o: $(KERNEL_DIR)/kernel/%.c
	@echo "Compiling $<"
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@
