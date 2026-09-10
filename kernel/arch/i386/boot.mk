include scripts/common.mk

ASM_SOURCES = $(wildcard $(KERNEL_DIR)/arch/i386/*.asm)
ASM_OBJECTS = $(patsubst %.asm,$(BUILD_DIR)/%.o,$(ASM_SOURCES))

.PHONY: all
all: ${ASM_OBJECTS} $(BUILD_DIR)/kernel.o

$(BUILD_DIR)/%.o: %.asm
	@echo "Compiling $<"
	@mkdir -p $(@D)
	@$(ASM) $(ASM_FLAGS) $< -o $@

$(BUILD_DIR)/kernel.o:
	@echo "Compiling kernel.c"
	@$(CC) $(CFLAGS) -c $(KERNEL_DIR)/kernel/kernel.c -o $@