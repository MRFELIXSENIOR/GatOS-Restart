#ifndef __GATOS_MBT2_H__
#define __GATOS_MBT2_H__

#include <stdint.h>

#define MULTIBOOT_TAG __attribute__((aligned(8), packed))

#define MULTIBOOT_TAG_TYPE_END                  0
#define MULTIBOOT_TAG_TYPE_BOOTLOADER_NAME      2
#define MULTIBOOT_TAG_TYPE_BASIC_MEMINFO        4
#define MULTIBOOT_TAG_TYPE_MEMORY_MAP           6

typedef struct MULTIBOOT_TAG {
    uint16_t type;
    uint16_t flags;
    uint32_t size;
} multiboot_tag;

typedef struct MULTIBOOT_TAG {
    uint32_t type;
    uint32_t size;
    uint32_t lower_mem;
    uint32_t upper_mem;
} multiboot_mem_info;

typedef struct MULTIBOOT_TAG {
    uint32_t size;
    uint32_t address_low, address_high;
    uint32_t length_low, length_high;
    uint32_t type;
#define MEMORY_AVAILABLE              1
#define MEMORY_RESERVED               2
#define MEMORY_ACPI_RECLAIMABLE       3
#define MEMORY_NVS                    4
#define MEMORY_DEFECTIVE              5
} multiboot_mem_map;

/*
    Returns physical address of a multiboot tag
*/
uint32_t multiboot_get_tag_addr(uint32_t mb_phys_addr, uint32_t tag_type);

#endif