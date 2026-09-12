#ifndef __GATOS_MBT2_H__
#define __GATOS_MBT2_H__

#include <stdint.h>

#define MULTIBOOT_TAG_TYPE_END               0
#define MULTIBOOT_TAG_TYPE_BASIC_MEMINFO     4

typedef struct __attribute__((aligned(8), packed))  {
    uint16_t type;
    uint16_t flags;
    uint32_t size;
} multiboot_tag_t;

typedef struct __attribute__((aligned(8), packed))  {
    uint32_t type;
    uint32_t size;
    uint32_t lower_mem;
    uint32_t upper_mem;
#define MULTIBOOT_MEMORY_AVAILABLE              1
#define MULTIBOOT_MEMORY_RESERVED               2
#define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE       3
#define MULTIBOOT_MEMORY_NVS                    4
#define MULTIBOOT_MEMORY_BADRAM                 5
} multiboot_mem_info_t;

/*
    Returns physical address of a multiboot tag
*/
uint32_t multiboot_get_tag_addr(uint32_t mb_phys_addr, uint32_t tag_type);

#endif