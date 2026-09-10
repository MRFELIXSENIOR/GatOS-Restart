extern _kernel_start
extern _kernel_end

KERNEL_MAP_ADDR equ 0xC0000000

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
align 4096
page_directory:         resb 4096
boot_page_table1:       resb 4096
boot_page_table2:       resb 4096
align 16
global stack_top
stack_bottom: resb 16384
stack_top:

section .multiboot.text
global _start
_start:
    push ebx
    push eax

    mov edi, boot_page_table1 - KERNEL_MAP_ADDR
    mov esi, 0
    mov ecx, 1023

.label_1:
    cmp esi, _kernel_start
    jl .fill_table1
    cmp esi, _kernel_end - KERNEL_MAP_ADDR
    jge .label_3

    mov edx, esi
    or edx, 0x003
    mov [edi], edx

.fill_table1:
    add esi, 4096
    add edi, 4
    loop .label_1

.label_3:
    mov dword [boot_page_table1 - KERNEL_MAP_ADDR + 1023 * 4], 0x000B8000 | 0x003 ; VGA video memory

    mov edi, boot_page_table2 -KERNEL_MAP_ADDR
    mov esi, 0x00400000
    mov ecx, 1024

.fill_table2:
    mov edx, esi
    or edx, 0x003
    mov [edi], edx

    add esi, 4096
    add edi, 4
    loop .fill_table2

    ; Link page tables
    mov dword [page_directory - KERNEL_MAP_ADDR + 0 * 4], boot_page_table1 - KERNEL_MAP_ADDR + 0x003
    mov dword [page_directory - KERNEL_MAP_ADDR + 768 * 4], boot_page_table1 - KERNEL_MAP_ADDR + 0x003

    mov dword [page_directory - KERNEL_MAP_ADDR + 1 * 4], boot_page_table2 - KERNEL_MAP_ADDR + 0x003
    mov dword [page_directory - KERNEL_MAP_ADDR + 769 * 4], boot_page_table2 - KERNEL_MAP_ADDR + 0x003

    mov ecx, page_directory - KERNEL_MAP_ADDR
    mov cr3, ecx

    mov ecx, cr0
    or ecx, 0x80010000
    mov cr0, ecx

    ; Enable PSE
    mov ecx, cr4
    or ecx, 0x00000010
    mov cr4, ecx

    lea ecx, [.higher_half]
    jmp ecx

section .text
.higher_half:
    mov dword [page_directory + 0 * 4], 0

    mov ecx, cr3
    mov cr3, ecx

    mov esp, stack_top

    ; Load gdt
    cli
    extern load_gdt
    call load_gdt
    sti

    ; Load tss
    mov ax, 0x28
    ltr ax

    extern kernel_main
    call kernel_main

.hang:
    cli
    hlt
    jmp .hang

.end: