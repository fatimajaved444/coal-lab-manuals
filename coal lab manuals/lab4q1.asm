[org 0x0100]

	mov ax, 0x6652 ; 6652 roll number
	mov bx, 0xfff3
	xor ax, bx

	mov ax, 0x4c00
	int 0x21