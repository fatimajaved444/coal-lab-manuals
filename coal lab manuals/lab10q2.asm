[org 0x0100]
	jmp start

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
grey_board:					; It'll print grey color board on black color board				; For grey color printing
		push bp				; Pushing so that previous value can be safe
		mov bp, sp
		push es				
		push di				
		push cx				

		mov ax, 0xb800
		mov es, ax
print_grey_row:					; This is the loop for printing grey color in each row
		mov bx, 0
		mov ax, 80
		mul bx
		add ax, 0
		shl ax, 1
		mov di, ax
		mov cx, 80			; After taking 6 columns from start and 10 columns from end
		mov ax, 0x072a			; Grey on Black Board

print_grey:
		mov [es:di], ax
		add di, 2
		sub cx, 1
		cmp cx, 0
		jnz print_grey

		mov ax, 0xb800
		mov es, ax
print_gr_col:					; This is the loop for printing grey color in each row
		mov bx, 0
		mov ax, 80
		mul bx
		add ax, 0
		shl ax, 1
		mov di, ax
		mov cx, 25			; After taking 6 columns from start and 10 columns from end
		mov ax, 0x072a			; Grey on Black Board

print_grey_col:
		mov [es:di], ax
		add di, 160
		sub cx, 1
		cmp cx, 0
		jnz print_grey_col

		mov ax, 0xb800
		mov es, ax
print_grey_row_1:					; This is the loop for printing grey color in each row
		mov bx, 24
		mov ax, 80
		mul bx
		add ax, 0
		shl ax, 1
		mov di, ax
		mov cx, 80			; After taking 6 columns from start and 10 columns from end
		mov ax, 0x072a			; Grey on Black Board

print_gre1:
		mov [es:di], ax
		add di, 2
		sub cx, 1
		cmp cx, 0
		jnz print_gre1

		mov ax, 0xb800
		mov es, ax
print_gr_col_1:					; This is the loop for printing grey color in each row
		mov bx, 0
		mov ax, 80
		mul bx
		add ax, 79
		shl ax, 1
		mov di, ax
		mov cx, 25			; After taking 6 columns from start and 10 columns from end
		mov ax, 0x072a			; Grey on Black Board

print_grey_col_1:
		mov [es:di], ax
		add di, 160
		sub cx, 1
		cmp cx, 0
		jnz print_grey_col_1

		pop cx
		pop di
		pop es
		pop bp
		pop ax
ret

game_start:
		call grey_board
ret
		
start:						; Start of our program
		call clrscr
		call game_start
jmp end


end:		
		mov ah, 0x1			; Work as system("pause")
		int 0x21

		mov ax, 0x4c00			; For program termination
		int 0x21