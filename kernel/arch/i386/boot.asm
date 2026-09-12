extern _kernel_start
extern _kernel_end

section .multiboot.data
align 8
header_start:
    dd 0xE85250D6
    dd 0
    dd (header_end - header_start)
    dd -(0xE85250D6 + 0 + (header_end - header_start))

    align 8
    dw 0
    dw 0
    dd 8
header_end:

section .bss
align 16
global stack_top
stack_bottom: resb 16384
stack_top:

section .multiboot.text
global _start
_start:
    mov edi, eax
    mov esi, ebx

    extern load_paging 
    call load_paging

    extern page_directory
    mov ecx, page_directory
    mov cr3, ecx

    mov ecx, cr0
    or ecx, 0x80000000
    mov cr0, ecx

    lea ecx, [.higher_half]
    jmp ecx

section .text
.higher_half:
    mov dword [page_directory], 0

    mov ecx, cr3
    mov cr3, ecx

    mov esp, stack_top

    ; Load gdt
    cli
    extern load_gdt
    call load_gdt

    ; Load tss
    extern load_tss
    call load_tss

    push edi
    push esi

    extern kernel_main
    call kernel_main
    add esp, 8
.hang:
    cli
    hlt
    jmp .hang

.end: