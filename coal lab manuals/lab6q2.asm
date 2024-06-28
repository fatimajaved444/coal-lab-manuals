[org 0x0100]

jmp start

clrcsr:
push es
push ax
push cx
push di

mov ax,0xb800
mov es,ax
xor di,di
mov ax,0x0720
mov cx,2000

cld
rep stosw

pop di
pop cx
pop ax
pop es

ret

drawrect:
push bp
mov bp,sp

mov di,[bp+10]
mov si,[bp+8]
mov ax , 0xb800
mov es,ax

A:mov word[es:di],0x272A
add di,2
cmp di,si
jne A

mov di,[bp+6]
mov si,[bp+4]

B:mov word[es:di],0x272A
add di,2
cmp di,si
jne B

mov di,[bp+10]
mov si,[bp+6]

C:mov word[es:di],0x272A
add di,160
cmp di,si
jne C

mov di,[bp+8]
mov si,[bp+4]

D:mov word[es:di],0x272A
add di,160
cmp di,si
jne D

mov word[es:1620],0x272A

ret

start: call clrcsr

;0x622A

mov ax, 162
push ax

mov ax, 180
push ax

mov ax, 1602
push ax

mov ax, 1620
push ax

call drawrect

mov ax,0x4c00
int 21h