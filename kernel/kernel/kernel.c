#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>

#include "fn.h"
#include "vga.h"
#include "multiboot2.h"

extern void load_idt();
extern void load_pmm(uint32_t upper);

extern void jmp2ring3(void);

void kernel_main(uint32_t mb_info_ptr, uint32_t mb_magic) {
    terminal_initialize();
    kernel_puts("Hello gatOS\n");
    kernel_puts("You are currently in the Kernel!\n");

    multiboot_mem_info* mb_mem_info = (multiboot_mem_info* )multiboot_get_tag_addr(mb_info_ptr, MULTIBOOT_TAG_TYPE_BASIC_MEMINFO);
    load_pmm(mb_mem_info->upper_mem);

    load_idt();
    kernel_puts("IDT Loaded\n");

    //jmp2ring3();
}