[org 0x0100]

	mov bx, [memory]
	mov ax, 0x6652
	mov cx, ax
	mov dx, ax
	and cx, bx
	or dx, bx
	xor ax, bx

	mov ax, 0x4c00
	int 0x21

memory:	dw 0