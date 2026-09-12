#include "multiboot2.h"

uint32_t multiboot_get_tag_addr(uint32_t mb_phys_addr, uint32_t tag_type) {
    uint8_t* mb_virtual_addr = (uint8_t*)(mb_phys_addr + 0xC0000000);
    multiboot_tag_t* tag = (multiboot_tag_t*)(mb_virtual_addr + 8);        // adding 8 to skip the fixed header
    while (tag->type != MULTIBOOT_TAG_TYPE_END) {
        if (tag->type == tag_type)
            return (uint32_t)(tag);

        uint32_t aligned_sz = (tag->size + 7) & ~7; //Some magical bits manipulating
                                                    //Rounding up to the next 8 bytes alignment boundary
                                                    //Then using AND to invert bits cutting it into a multiple of 8 bytes
                                                    //(8 + 7) & ~7 = 8,    (13 + 7) & ~7 = 16

        tag = (multiboot_tag_t*)((uint8_t*)tag + aligned_sz);
    }

    return 0;
}
