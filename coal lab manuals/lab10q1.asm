[org 0x0100]
	jmp start

; Data
msg:		db 'Fatima Javed', 0
oldisr:		dd 0

clrscr:						; Screen Clearing
	push ax
        push di
	push cx
        push es
        mov ax, 0xb800    			;b800 starting adress
        mov es, ax
        xor di, di    	 			;xor answer will be zero,so di initialized to zero
	mov ax, 0x0720 				; 0=backgroud black,7=forground white of spaces so not visible
	mov cx, 2000    

	cld					; Will set DF=0. So, it'll move from lower to higher address
	rep stosw				; Will push spaces until whole screen become clear

        pop es
	pop cx
        pop di
        pop ax
ret
clrvar:						; Clearing all the variables. In order to get rid of garbage values
	xor ax, ax				
	xor bx, bx				
	xor cx, cx				
	xor dx, dx				
	xor si, si				
	xor di, di				
ret

;------------------------------------------------------------------------------------------------------------------------------------------------
printstr:	
		push bp
		mov bp, sp
		push es
		push ax
		push cx
		push si
		push di
	
		push ds
		pop es
		mov di, [bp+4]
		mov cx, 0xffff
		xor al, al
		repne scasb
		mov ax, 0xffff
		sub ax, cx
		dec ax
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

nextchar:	lodsb
		stosw
		loop nextchar

exit:		pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
ret 8

;------------------------------------------------------------------------------------------------------------------------------------------------
kbisr: 
	push ax
	push es

	mov ax, 0xb800
	mov es, ax
	
 	in al, 0x60  		; read a char from keyboard port
 	cmp al, 0x2a 		; is the key left shift
 	jne cmp2  		; no, try next comparison

	mov ax, 10
	push ax
	mov ax, 3
	push ax
	mov ax, 0x07
	push ax
	mov ax, msg
	push ax
	call printstr
cmp2:
	cmp al, 0xaa
	jne exit1

        mov ax, 0xb800    			;b800 starting adress
        mov es, ax
        xor di, di    	 			;xor answer will be zero,so di initialized to zero
	mov ax, 0x0720 				; 0=backgroud black,7=forground white of spaces so not visible
	mov cx, 2000    

	cld					; Will set DF=0. So, it'll move from lower to higher address
	rep stosw				; Will push spaces until whole screen become clear

exit1: 
 	pop es
 	pop ax
 	jmp far [cs:oldisr] 	; call the original ISR

;------------------------------------------------------------------------------------------------------------------------------------------------
game_start:
		xor ax, ax
 		mov es, ax 			; point es to IVT base
 		mov ax, [es:9*4]
 		mov [oldisr], ax 		; save offset of old routine
 		mov ax, [es:9*4+2]
 		mov [oldisr+2], ax	 	; save segment of old routine

		cli 				; disable interrupts
 		mov word [es:9*4], kbisr 	; store offset at n*4
 		mov [es:9*4+2], cs 		; store segment at n*4+2
 		sti 	

		
	leftorright: 
		mov ah, 0 			; service 0 – get keystroke
 		int 0x16 			; call BIOS keyboard service
 		cmp al, 27 			; is the Esc key pressed
 		jne leftorright 		; if no, check for next key
 		mov ax, [oldisr]		; read old offset in ax
 		mov bx, [oldisr+2] 		; read old segment in bx
		cli 				; disable interrupts
 		mov [es:9*4], ax 		; restore old offset from ax
 		mov [es:9*4+2], bx 		; restore old segment from bx
 		sti				; enable interrupts		 				
ret
		
;------------------------------------------------------------------------------------------------------------------------------------------------
start:						; Start of our program
		call clrscr
		call clrvar
		call game_start
jmp end

;------------------------------------------------------------------------------------------------------------------------------------------------
end:		
		mov ah, 0x1			; Work as system("pause")
		int 0x21

		mov ax, 0x4c00			; For program termination
		int 0x21