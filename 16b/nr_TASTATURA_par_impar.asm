;Verificam daca un numar este par sau impar - tastatura

org 100h
.data
    nr db ?
    msg_par db 10, 13,'Numarul este par $'
    msg_impar db 10, 13,'Numarul este impar $'
    msg db  'Introduceti numarul: $'

.code
    mov ah, 09h
    lea dx, msg
    int 21h

    ; Citim numarul de la tastatura
    mov ah, 01h
    int 21h
    sub al, 30h  ; Convertim caracterul ASCII la valoare numerica

    mov AH, 0
    mov BL, 2
    div BL

    cmp AH, 0
    jnz impar

    mov DX, offset msg_par
    jmp afisare

impar:
    mov DX, offset msg_impar

afisare:
    mov AH, 09h
    int 21h

ret
