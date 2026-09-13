#include <stdint.h>

#define KERNEL_PAGE_SIZE    1024        // 4 MBs

#define PAGE_SIZE           4096
#define MAX_BLOCKS          1048576
//1 byte stores 8 frames
#define BITMAP_SIZE (MAX_BLOCKS / sizeof(char))

static uint8_t bitmap[BITMAP_SIZE];
static uint32_t total_blocks = 0;
static uint32_t used_blocks = 0;

#define SETBIT(bit)         (bitmap[bit / 8] |= (1 << (bit % 8)))
#define CLEARBIT(bit)       (bitmap[bit / 8] &= ~(1 << (bit % 8)))
#define TESTBIT(bit)        (bitmap[bit / 8] & (1 << (bit % 8)))

void load_pmm(uint32_t upper) {
    for (uint32_t i = 0; i < BITMAP_SIZE; i++)
        bitmap[i] = 0xFF;     // Mark all as used

    total_blocks = (upper * 1024) / PAGE_SIZE;      // Only mark memories beyond the kernel
    total_blocks = (total_blocks > MAX_BLOCKS)? MAX_BLOCKS : total_blocks;

    for (uint32_t i = KERNEL_PAGE_SIZE; i < total_blocks; i++)
        CLEARBIT(i);
}