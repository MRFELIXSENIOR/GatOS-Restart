section .text


global jmp2ring3
jmp2ring3:
    mov ax, (0x20 | 3)
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov eax, esp
	push (0x20 | 3)
	push eax
	pushf
	push (0x18 | 3)
	push ring3_main
	iret