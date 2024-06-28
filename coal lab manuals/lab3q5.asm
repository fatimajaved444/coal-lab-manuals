[org 0x0100]
jmp start
array:dw 111,999,888,888,11,99,88,88,1,9,8,8

start :mov cx,12
mov bx,array
mov ax,111
line1:add bx,2
sub cx,1
jz end 
cmp ax,[bx]
jc line1

12:mov ax,[bx]
jmp line1

end:mov ax, 0x4c00
int 0x21