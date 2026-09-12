#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>

#include "fn.h"
#include "multiboot2.h"

extern void terminal_initialize();
extern void kernel_puts(const char* data);

extern void load_idt();
extern void load_pmm(uint32_t upper);

extern void jmp2ring3(void);

void kernel_main(uint32_t mb_info_ptr, uint32_t mb_magic) {
    terminal_initialize();
    kernel_puts("Hello gatOS\n");
    kernel_puts("You are currently in the Kernel!\n");

    char itoa_buf[32];
    if (mb_magic != 0x36d76289) {
        kernel_puts("FATAL: WRONG BOOT INFOMATION PASSED!\nMULTIBOOT EAX MAGIC: ");
        kernel_puts(gatOS_itoa(mb_magic, itoa_buf, 16));
        kernel_puts("\n");
        __asm__ volatile ("cli; hlt");
    } else {
        kernel_puts("Correct boot info magic passed!\n");
    }

    multiboot_mem_info_t* mb_mem_info = (multiboot_mem_info_t*)multiboot_get_tag_addr(mb_info_ptr, MULTIBOOT_TAG_TYPE_BASIC_MEMINFO);

    kernel_puts(gatOS_itoa(mb_mem_info->upper_mem, itoa_buf, 16));
    kernel_puts(gatOS_itoa(mb_mem_info->lower_mem, itoa_buf, 16));
    kernel_puts("\n");

    load_idt();
    kernel_puts("IDT Loaded\n");

    //jmp2ring3();
}