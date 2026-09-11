section .text
global jmp2ring3
jmp2ring3:
    mov ax, (0x20 | 3)
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	push (0x20 | 3)
	mov eax, esp
	push eax
	pushf
	push (0x18 | 3)
	push .label_1
	iret
.label_1:
	jmp .label_1

section .rodata
	msg: db "YOU ARE IN RING 3!", 10, 0