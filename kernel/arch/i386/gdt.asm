[bits 32]
section .rodata
align 8
gdt_start:
    dq 0
gdt_code:           ; 0x08
    dw 0xFFFF           ; Limit         0-15
    dw 0                ; Base          16-31
    db 0                ; Base          32-39
    db 0x9A             ; Access byte   40-47
    db 11001111b        ; Limit + Flags 48-51 + 52-55
    db 0                ; Base          56-63
gdt_data:           ; 0x10
    dw 0xFFFF
    dw 0
    db 0
    db 0x92
    db 11001111b
    db 0
gdt_user_code:      ; 0x18
    dw 0xFFFF
    dw 0
    db 0
    db 0xFA
    db 11001111b
    db 0
gdt_user_data:      ; 0x20
    dw 0xFFFF
    dw 0
    db 0
    db 0xF2
    db 11001111b
    db 0
gdt_task_state:     ; 0x28
    dw 103              ; sizeof(TSS) - 1
    dw 0                ; Patch at runtime
    db 0                ; Patch at runtime
    db 0x89
    db 0
    db 0

gdt_end:
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

section .text
global load_gdt
load_gdt:
extern ____tss
    mov eax, ____tss
    mov [gdt_task_state + 2], ax
    shr eax, 16
    mov [gdt_task_state + 4], al
    mov [gdt_task_state + 7], ah

    lgdt [gdt_descriptor]
    jmp 0x08:.reload
    
.reload:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    ret