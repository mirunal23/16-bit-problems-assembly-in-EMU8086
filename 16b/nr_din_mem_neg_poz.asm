;Verificam daca un numar este pozitiv sau negativ

org 100h
.data
nr db 2
msg_poz db 'Numarul este pozitiv $'
msg_neg db 'Numarul este negativ $' 

.code 
mov AH, 0
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