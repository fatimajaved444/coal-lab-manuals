[org 0x0100]

jmp start

c1 : call c2
ret

c2 : call c3
ret

c3 : call c4
ret

c4 : mov ax, 5
ret

start : mov ax, 0
mov bx, 0
call c1
jmp end

end : mov ax, 0x4c00
int 0x21