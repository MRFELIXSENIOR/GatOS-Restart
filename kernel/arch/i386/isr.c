#include "idt.h"
#include "vga.h"

const char* exception_messages[] = {
    "Division by Zero\n",
    "Debug\n",
    "Non-maskable Interrupt\n",
    "Breakpoint\n",
    "Overflow from INTO instruction\n",
    "BOUND Range exceeded\n",
    "Invalid Opcode\n",
    "No math coprocessor\n",
    "Double Fault\n",
    "Coprocessor segment overrun\n",
    "Invalid TSS\n",
    "Segment not present\n",
    "Stack-Segment Fault\n",
    "General Protection Fault\n",
    "Page Fault\n",
    "",
    "x87 FPU Floating-point error (Math Fault)\n",
    "Alignment check exception\n",
    "Machine check exception\n",
    "SIMD Floating-point exception\n",
    "Virtualization exception\n",
    "Control Protection exception\n",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
};

const char* page_fault_messages[] = {
    "Supervisory process tried to read a non-present page entry\n",
    "Supervisory process tried to read a page and caused a protection fault\n",
    "Supervisory process tried to write to a non-present page entry\n",
    "Supervisory process tried to write a page and caused a protection fault\n",
    "User process tried to read a non-present page entry\n",
    "User process tried to read a page and caused a protection fault\n",
    "User process tried to write to a non-present page entry\n",
    "User process tried to write a page and caused a protection fault\n"
};

typedef struct {
    uint32_t ds;
    uint32_t edi, esi, ebp, esp, ebx, edx, ecx, eax;
    uint32_t int_number, error_code;
    uint32_t eip, cs, eflags, useresp, ss;
} registers_t;

void isr_handler(registers_t* regs) {
    kernel_puts(exception_messages[regs->int_number]);
    
    if (regs->int_number == 14) {
        kernel_puts("Error: ");
        kernel_puts(page_fault_messages[regs->error_code]);
    }
    
    if (regs->error_code != 0) {
        kernel_puts("CRASHED!!!!!");
        __asm__ volatile ("cli; hlt");
    }
}

void irq_handler(registers_t* regs) {
    kernel_puts("IRQ Triggered!\n");
}
