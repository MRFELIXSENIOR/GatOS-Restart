#include <stdbool.h>

#include "idt.h"

#define KERNEL_CODE_SEGMENT 0x08

__attribute__((aligned(0x10)))
static idt_entry_t idt[IDT_ENTRIES];
static idtr_t idtr;
extern void* isr_stub_table[];

void idt_set_descriptor(uint8_t vector, void* isr) {
    idt_entry_t* descriptor             = &idt[vector];
    descriptor->low16                   = (uint32_t)isr & 0xFFFF;
    descriptor->kernel_cs               = KERNEL_CODE_SEGMENT;
    descriptor->attributes              = INTERRUPT_GATE;
    descriptor->high16                  = (uint32_t)isr >> 16;
    descriptor->reserved                = 0;
}

void load_idt() {
    idtr.base = (uint32_t)&idt;
    idtr.limit = (uint16_t)sizeof(idt_entry_t) * 256 - 1;

    for (uint8_t vector = 0; vector < 48; vector++)           // 48 = 32 ISRs + 16 IRQs
        idt_set_descriptor(vector, isr_stub_table[vector]);

    __asm__ volatile ("lidt [%0]" : : "r"(&idtr));
}