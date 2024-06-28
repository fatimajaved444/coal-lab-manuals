[org 0x10100]
       mov ax,0
       mov bx,0
       mov cx,0
       mov bx,[num]
       mov cx,[num]
loop1: add ax,bx
       sub cx,1
       jnz loop1

	 mov ax,0x4c00
	 int 0x21

num: dw 5

