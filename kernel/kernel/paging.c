#include <stdint.h>

#define KERNEL_PAGE_SIZE 768

extern uint32_t _kernel_start;
extern uint32_t _kernel_end;

#define PAGE_PRESENT         (1ULL << 0)
#define PAGE_READWRITE       (1ULL << 1)
#define PAGE_USER            (1ULL << 2)

__attribute__((section(".multiboot.data"), aligned(4096)))  uint32_t page_directory[1024];
__attribute__((section(".multiboot.data"), aligned(4096)))  uint32_t page_table[1024];

void __attribute__((section(".multiboot.text"))) load_paging(void) {
    uint32_t kernel_start = (uint32_t)&_kernel_start;
    uint32_t kernel_end_phys = (uint32_t)&_kernel_end - 0xC0000000;

    for (int i = 0; i < 1023; i++) {
        uint32_t addr = i * 4096;
        if (addr >= kernel_start) {
            if (addr >= kernel_end_phys)
                break;
                 
            page_table[i] = addr | PAGE_PRESENT | PAGE_READWRITE;
        } else {
            page_table[i] = 0;
        }
    }

    page_table[1023] = 0x000B8000 | PAGE_PRESENT | PAGE_READWRITE;

    page_directory[0] = ((uint32_t)page_table) | PAGE_PRESENT | PAGE_READWRITE;
    page_directory[KERNEL_PAGE_SIZE] = ((uint32_t)page_table) | PAGE_PRESENT | PAGE_READWRITE;

    for (int i = 1; i < 1024; i++) {
        if (i == KERNEL_PAGE_SIZE) continue;
        page_directory[i] = 0;
    }
}