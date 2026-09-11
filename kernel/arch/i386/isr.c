#include "idt.h"

const char* exception_messages[] = {
    "Division by Zero",
    "Debug",
    "Non-maskable Interrupt",
    "Breakpoint",
    "Overflow from INTO instruction",
    "BOUND Range exceeded",
    "Invalid Opcode",
    "No math coprocessor",
    "Double Fault",
    "Coprocessor segment overrun",
    "Invalid TSS",
    "Segment not present",
    "Stack-Segment Fault",
    "General Protection Fault",
    "Page Fault",
    "Reserved",
    "x87 FPU Floating-point error (Math Fault)",
    "Alignment check",
    "Machine check",
    "SIMD Floating-point exception",
    "Virtualization exception",
    "Control Protection exception",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved"
};

typedef struct {
    uint32_t ds;
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    uint32_t int_number, error_code;
    uint32_t eip, cs, eflags, useresp, ss;
} registers_t;

extern void kernel_puts(const char*);
void isr_handler(registers_t* regs) {
    kernel_puts(exception_messages[regs->int_number]);
    if (regs->error_code != 0) {
        __asm__ volatile ("cli; hlt");
    }
}

void irq_handler(registers_t* regs) {
    kernel_puts("IRQ Triggered!\n");
}
