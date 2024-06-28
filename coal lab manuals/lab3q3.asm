[org 0x0100]
jmp start
array: dw 1, 9, 9,9, 8, 8,8, 8, 8,8, 1, 1, 9, 9, 8, 8, 8, 8, 1, 9, 8, 8
num:dw 9

start:mov cx,22
mov ax,0
mov bx,array
mov dx,9

l1:cmp dx,[bx]
jz 12
add bx,2
sub cx,1
jnz l1
jz end

l2:add ax,1
add bx,2
sub cx,1
jnz l1

end:mov ax, 0x4c00
int 0x21
