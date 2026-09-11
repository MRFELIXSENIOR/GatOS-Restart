#ifndef __GATOS_IDT_H__
#define __GATOS_IDT_H__

#include <stdint.h>

#define IDT_ENTRIES 256
#define INTERRUPT_GATE 0x8E

__attribute__((noreturn)) void exception_handler(void);
void idt_set_descriptor(uint8_t vector, void* isr);
void load_idt(void);

typedef struct {
    uint16_t    low16;
    uint16_t    kernel_cs;
    uint8_t     reserved;
    uint8_t     attributes;
    uint16_t    high16;
} __attribute__((packed)) idt_entry_t;

typedef struct {
    uint16_t    limit;
    uint32_t    base;
} __attribute__((packed)) idtr_t;

#endif