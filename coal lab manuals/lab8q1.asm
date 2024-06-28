[org 0x0100]

	jmp start
;---------------------------------------------
	msg1: db 'Hi! I am fatima javed.', 0
	msg2: db 'I am funny.', 0
	msg3: db 'I am from FAST.', 0
	msg4: db 'My Roll No is 22L-6652.', 0
;-----------------------------------------------
clrscr:
  	push es
  	push ax
  	push cx
  	push di

  	mov ax, 0xb800
  	mov es, ax
  	xor di, di
  	mov ax, 0x0720
  	mov cx, 2000
 
	cld
	rep stosw

  	pop di
  	pop cx
  	pop ax
  	pop es
	ret
;----------------------------------------------
strlen:
	push bp
	mov bp, sp
	push es
	push cx
	push di

	les di, [bp+4]
	mov cx, 0xffff
	xor al, al
	repne scasb
	mov ax, 0xffff
	sub ax, cx
	dec ax

    	pop di
  	pop cx
 	 pop es
 	 pop bp
	ret 2
;---------------------------------------------
printstr:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push bx
	push dx

	mov ax, [bp+4]
	push ax
	call strlen
	cmp ax, 0
	jz exit
	mov cx, ax

	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte [bp+8]
	add ax, [bp+10]
	shl ax, 1
	mov di, ax
  	mov si, [bp+4]
	mov ah, [bp+6]
	cld

nextchar:
	lodsb
	stosw
	loop nextchar

exit:
   	 pop dx
    	pop bx
  	pop si
  	pop cx
  	pop ax
  	pop es
  	pop bp
	ret 8
start:
 	 call clrscr

	mov ah, 0
	int 0x16
 	 mov ax, 0
  	push ax
  	mov ax, 0
  	push ax
  	mov ax, 0x07 ;color
  	push ax
  	mov ax, msg1
  	push ax
  	call printstr

	mov ah, 0
	int 0x16
	mov ax, 0
  	push ax
  	mov ax, 1
  	push ax
  	mov ax, 0x07 ;color
  	push ax
  	mov ax, msg2
  	push ax
  	call printstr

	mov ah, 0
	int 0x16
        mov ax, 0
  	push ax
  	mov ax, 2
  	push ax
  	mov ax, 0x07 ;color
  	push ax
  	mov ax, msg3
  	push ax
  	call printstr

	mov ah, 0
	int 0x16
        mov ax, 0
 	 push ax
  	mov ax, 3
  	push ax
  	mov ax, 0x07 ;color
  	push ax
  	mov ax, msg4
  	push ax
  	call printstr

	jmp end

end:
mov ah, 0x1
int 21h

mov ax,0x4c00
int 21h