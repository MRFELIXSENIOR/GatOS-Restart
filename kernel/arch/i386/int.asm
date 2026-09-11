[bits 32]
section .text
%macro ISR_ERROR 1
isr_stub_%+%1:
    cli
    push byte %1
    jmp isr_common
%endmacro

%macro ISR_NOERR 1
isr_stub_%+%1:
    cli
    push byte 0
    push byte %1
    jmp isr_common
%endmacro

%macro IRQ 2
isr_stub_%+%2:
    cli
    push byte %1
    push byte %2
    jmp irq_common
%endmacro

ISR_NOERR 0         ;   Division by Zero
ISR_NOERR 1         ;   Debug
ISR_NOERR 2         ;   Non-maskable Interrupt
ISR_NOERR 3         ;   Breakpoint
ISR_NOERR 4         ;   Overflow from INTO instruction
ISR_NOERR 5         ;   BOUND Range exceeded
ISR_NOERR 6         ;   Invalid Opcode
ISR_NOERR 7         ;   No math coprocessor
ISR_ERROR 8         ;   Double Fault
ISR_NOERR 9         ;   Coprocessor segment overrun
ISR_ERROR 10        ;   Invalid TSS
ISR_ERROR 11        ;   Segment not present
ISR_ERROR 12        ;   Stack-Segment Fault
ISR_ERROR 13        ;   General Protection Fault
ISR_ERROR 14        ;   Page Fault
ISR_NOERR 15        ;   Reserved
ISR_NOERR 16        ;   x87 FPU Floating-point error (Math Fault)
ISR_ERROR 17        ;   Alignment check
ISR_NOERR 18        ;   Machine check
ISR_NOERR 19        ;   SIMD Floating-point exception
ISR_NOERR 20        ;   Virtualization exception
ISR_NOERR 21        ;   Control Protection exception
ISR_NOERR 22        ;   Reserved
ISR_NOERR 23        ;   Reserved
ISR_NOERR 24        ;   Reserved
ISR_NOERR 25        ;   Reserved
ISR_NOERR 26        ;   Reserved
ISR_NOERR 27        ;   Reserved
ISR_NOERR 28        ;   Reserved
ISR_NOERR 29        ;   Reserved
ISR_ERROR 30        ;   Reserved
ISR_NOERR 31        ;   Reserved

IRQ     0,      32
IRQ     1,      33
IRQ     2,      34
IRQ     3,      35
IRQ     4,      36
IRQ     5,      37
IRQ     6,      38
IRQ     7,      39
IRQ     8,      40
IRQ     9,      41
IRQ     10,     42
IRQ     11,     43
IRQ     12,     44
IRQ     13,     45
IRQ     14,     46
IRQ     15,     47

global isr_stub_table   ; pointer table
isr_stub_table:
%assign i 0
%rep 48
    dd isr_stub_%+i
%assign i i+1
%endrep

extern isr_handler
isr_common:
    pusha
    mov ax, ds
    push eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    push esp
    call isr_handler
    add esp, 4

    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    popa
    add esp, 8
    iret

extern irq_handler
irq_common:
    pusha
    mov ax, ds
    push eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call irq_handler

    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    popa
    add esp, 8
    iret