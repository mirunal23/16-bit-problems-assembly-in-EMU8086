;Verificam daca un numar este par sau impar

org 100h

.data
    nr db 2
    msg_par db 'Numarul este par $'
    msg_impar db 'Numarul este impar $'

.code
    mov AL, nr
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
