[org 0x0100]

	jmp start;near jump

start:	mov dx, 2
	sub dx, 1
	cmp dx, 0
    	jnz loop1;short jump

loop1:	mov ax, 0x1000   
	mov bx, 0x2000  
	jmp loop2  ;far jump   

loop2:	mov ax, 1445h
    	add ax, 5893h    
    	sub ax, 4321h    

	mov ax, 0x4c00
	int 0x21