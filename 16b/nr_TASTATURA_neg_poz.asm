;Verificam daca un numar este pozitiv sau negativ

org 100h
.data
nr db ?
msg_poz db 10,13, 'Numarul este pozitiv $'
msg_neg db 10,13, 'Numarul este negativ $' 
msg db 'Introduceti un numar: $'

.code 
mov ah, 09h
lea dx, [msg]
int 21h

mov ah, 01h     ; citim un caracter de la tastatura
int 21h
sub al, 30h 

cmp AL, 0
jns et
    mov DX, offset msg_neg
    jmp afisare

et:
    mov DX, offset msg_poz
    
afisare:
    mov AH, 09h
    int 21h

ret