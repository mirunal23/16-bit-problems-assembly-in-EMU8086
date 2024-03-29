org 100h

.data
    numar1 db 60h ; Numarul hexazecimal 60h
    numar2 db 20h ; Numarul hexazecimal 20h
    diferenta db ?
    sir3 db "Diferenta este: $"

.code
    ; Citirea primului numar din memorie
    mov al, numar1
    mov numar1, al

    ; Citirea celui de-al doilea numar din memorie
    mov bl, numar2
    mov numar2, al

    ; Calculul diferen?ei
    mov al, numar1
    sub al, bl
    mov diferenta, bl
 
    ; Afisarea rezultatului
    mov dx, offset sir3
    mov ah, 09h
    int 21h

    ; Afisarea rezultatului hexazecimal
    mov al, diferenta
    mov ah, 0Eh
    add al, 30h 
    int 10h


ret


