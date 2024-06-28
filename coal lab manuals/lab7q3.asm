[org 0x0100]
jmp start

message1: db 'Name: Fatima Javed', 0 
message2: db 'Institute: FAST School of Computing', 0 
message3: db 'Batch: 2022', 0 
message4: db 'Roll no# 22l-6652', 0 
message5: db 'Address: Lahore ,Pakistan', 0 

clrscr:
push es
push ax
push cx
push di
mov ax, 0xb800
  mov es, ax ; point es to video base
  xor di, di ; point di to top left column
  mov ax, 0x0720 ; space char in normal attribute
  mov cx, 2000 ; number of screen locations
  cld ; auto increment mode
  rep stosw ; clear the whole screen
  pop di
pop cx
  pop ax
  pop es
  ret
 
printstr: push bp
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
mov di,ax 
mov si, [bp+4]
mov ah, [bp+6]
cld
nextchar: lodsb 
stosw 
loop nextchar 
exit: pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 8
delay:
push ax
push cx
mov cx,0xffff
l1:
mov ax,10
l2:
dec ax
jnz l2
dec cx
jnz l1
pop cx
pop ax
ret
 

start:
call clrscr
mov ax, 10
push ax
mov ax, 10
push ax
mov ax, 0x0f
push ax
mov ax, message1
push ax
call delay 
call printstr 

mov ax, 10
push ax
mov ax, 11
push ax
mov ax, 0x0f
push ax
mov ax, message2
push ax 
call delay 
call printstr 

mov ax, 10
push ax
mov ax, 12
push ax
mov ax, 0x0f
push ax
mov ax, message3
push ax 
call delay 
call printstr

mov ax, 10
push ax
mov ax, 13
push ax
mov ax, 0x0f
push ax
mov ax, message4
push ax 
call delay 
call printstr 

mov ax, 10
push ax
mov ax, 14
push ax
mov ax, 0x0f
push ax
mov ax, message5
push ax 
call delay 
call printstr 

mov ax, 0x4c00
int 0x21