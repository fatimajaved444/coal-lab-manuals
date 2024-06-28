[org 0x0100]

jmp start

w: dw 70
x: dw 50
y: dw 100
c: dw 50 ; color
;-------------------------------------------------
clrscr: ; This Function will clear the screen
push ax
push di
push es

mov ax, 0xb800
mov es, ax
mov di, 0

nextloc:
mov word [es:di], 0x0720
add di, 2
cmp di, 4000
jne nextloc

pop es
pop di
pop ax
ret
;------------------------------------------------
start:
call clrscr
mov ah, 0
mov al, 13h
int 10h
; draw diagonal 11:

mov dx, 0
mov bx, [x]
add bx, [w]
mov cx, [x]
mov dx, [y]
mov al, [c]
u1:
inc dx
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx, 100
jbe u1
;wait for keypress
mov ah, 0
int 16h

; draw diagonal 12: changing x,y coordinates

mov word [x], 100
mov word [y], 50
mov cx, 0
mov dx, 0
mov bx, [x]
add bx, [w]
mov cx, [x]
mov dx, [y]
mov al, [c]

u2:
inc dx
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx, 150
jbe u2
;wait for keypress
mov ah, 0
int 16h

; draw diagonal 13: changing x,y coordinates

mov word [x], 50
mov word [y], 100
mov cx, 0
mov dx, 0
mov bx, [x]
add bx, [w]
mov cx, [x]
mov dx, [y]
mov al, [c]

u3:
sub dx, 1
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx, 99
jbe u3
;wait for keypress
mov ah, 0
int 16h

; draw diagonal 14: changing x,y coordinates

mov word[x], 100
mov word[y], 150
mov cx, 0
mov dx, 0
mov bx, [x]
add bx, [w]
mov cx, [x]
mov dx, [y]
mov al, [c]

u4:
sub dx, 1
mov ah, 0ch ; put pixel
int 10h
inc cx
cmp cx, 150
jbe u4
;wait for keypress

mov ah, 0
int 16h
mov ax,0x4c00
int 0x21