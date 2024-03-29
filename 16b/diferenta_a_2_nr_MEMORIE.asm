org 100h

.data
    numar1 db 9
    numar2 db 5
    diferenta db ?
    sir3 db  "Diferenta este $"

.code
    ; Citirea primului numar din memorie
    mov al, [numar1]
    sub al, 30h ; Conversia din ASCII în valoare numerica
    mov numar1, al

    ; Citirea celui de-al doilea numar din memorie
    mov al, [numar2]
    sub al, 30h ; Conversia din ASCII în valoare numerica
    mov numar2, al

    ; Calculul diferen?ei
    mov al, numar1
    sub al, numar2
    mov diferenta, al

    ; Afisarea rezultatului
    mov dx, offset sir3
    mov ah, 09h
    int 21h

    ; Afisarea rezultatului hexazecimal
    mov al, diferenta
    add al, 30h ; Adaugam 30h pentru a reveni la codul ASCII al cifrei
    mov ah, 0Eh
    int 10h

ret
