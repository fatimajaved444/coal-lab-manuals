[org  0x100]
jmp start
rollno:dw 0x6652
sum:dw 0
num:	push bp
  	  mov bp,sp
  	  mov cx,16 
  	  mov bx,0
l1:
     	 shr ax,1
    	  jnc l2
    	  add bx,1
    	  sub cx,1
    	  jnz l1
l2:	sub cx,1
      	 cmp cx,0
      	 jnz l1
      	 mov ax,bx 
      	 pop bp
      	 ret


start:	 mov ax ,[rollno]
     	 call num
	add ax,7
l3:	mov bx,ax
     	 mov cx,0
l4:	add cx,1
    	 add dx,cx
    	 cmp bx,cx
     	jnz loop4
	sub bx,1
	mov cx,0
l5:	add cx,1
     	add dx,cx
    	 cmp bx,cx
  	   jnz loop5
	add [sum] ,dx
	dec ax 
	cmp ax,0
	jnz l3

mov ax,0x4c00
int 0x21
 