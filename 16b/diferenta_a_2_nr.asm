org 100h

.data
    numar1 db ?
    numar2 db ?
    diferenta db ?
    sir1 db "Tasteaza primul numar $"
    sir2 db 10,13, "Tasteaza al doilea numar $"
    sir3 db 10,13, "Diferenta este $"
.code
    mov dx, offset sir1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h

    sub al, 30h
    mov numar1, al

    mov dx, offset sir2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h

    sub al, 30h
    mov numar2, al

    ; Calculul diferentei
    mov al, numar1
    sub al, numar2
    mov diferenta, al

    ; Afisarea rezultatului
    mov dx, offset sir3
    mov ah, 09h
    int 21h

    mov al, diferenta
    add al, 30h ; Adaugam 30h pentru a reveni la codul ASCII al cifrei
    mov ah, 0Eh
    int 10h

ret
