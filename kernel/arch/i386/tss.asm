struc TSS
    .link:      resw 2            ; Previous TSS link + reserved
    .esp0:      resd 1            ; Kernel Stack Pointer (Ring 0)
    .ss0:       resw 2            ; Kernel Stack Segment + reserved
    .esp1:      resd 1
    .ss1:       resw 2
    .esp2:      resd 1
    .ss2:       resw 2
    .cr3:       resd 1            ; Page Directory Base Address
    .eip:       resd 1
    .eflags:    resd 1
    .eax:       resd 1
    .ecx:       resd 1
    .edx:       resd 1
    .ebx:       resd 1
    .esp:       resd 1
    .ebp:       resd 1
    .esi:       resd 1
    .edi:       resd 1
    .es:        resw 2
    .cs:        resw 2
    .ss:        resw 2
    .ds:        resw 2
    .fs:        resw 2
    .gs:        resw 2
    .ldt:       resw 2
    .trap:      resw 1
    .iomap:     resw 1
    .size:
endstruc

section .bss
align 4
global ____tss
____tss:    resb TSS.size

extern stack_top
section .text
    mov eax, stack_top
    mov [____tss + TSS.esp0], eax

    call flush_tss

global flush_tss
flush_tss:
    mov ax, (5 * 8) | 0
    ltr ax
    ret