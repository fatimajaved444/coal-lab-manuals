[org 0x0100]
jmp start
	rollno:dw 0x6652
	
num: 	push bp
	mov bp,sp
	mov cx,16

l1:	shr ax,1
	jnc skip
	add bx,1
	sub cx,1
	jnz l1

skip: 	sub cx,1
	cmp cx,0
	jnz l1
	mov ax,bx
	pop bp
	ret

start: mov ax,[rollno]
	call num

	mov ax,0x4c00
	int 0x21