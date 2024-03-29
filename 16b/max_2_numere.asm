;Maximul a doua numere definite in memorie

org 100h
.data 
a db 3
b db 7
max db ?
msg db 'Maximul este: ' ,'$'

.code
procedura proc
    push AX
    push BX
    push DX

mov AL, a
mov BL, b
cmp AL, BL

jg et2
mov max, BL

jmp et3

et2:
    mov max, AL
    
et3:
    lea DX, msg
    mov AH, 09h
    int 21h 
    mov AL, max
    add AL, 30h
    mov AH, 0Eh
    int 10h

pop DX
pop BX
pop AX

procedura endp
ret