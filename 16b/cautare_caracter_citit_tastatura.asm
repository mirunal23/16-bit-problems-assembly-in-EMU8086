org 100h
.data
    contor db 0
    sir db 'Acesta este un sir de caractere', '$'
    l equ $-sir-1
    car db 0    ; Caracterul introdus de la tastatura
    mesaj_memorie db 'Acesta este un sir de caractere', '$' 
    mesaj_caracter db 10, 13, 'Introduceti caracterul dorit: $'
    mesaj_gasit db 10, 13, 'Caracterul a fost gasit de $ ori.'

.code
start:
        ; Afisam mesajul din memorie
        mov ah, 09h
        lea dx, [mesaj_memorie]
        int 21h

        ; Afisam mesajul pentru introducerea caracterului
        mov ah, 09h
        lea dx, [mesaj_caracter]
        int 21h

        ; Citim caracterul de la tastatura
        mov ah, 01h
        int 21h
        mov [car], al

        ; Restul codului ramane neschimbat
        mov SI, 0
        mov AL, [car]

    cautare_caracter:
        cmp AL, [sir + SI]
        jne ies
        inc contor

    ies:
        inc SI
        cmp SI, l
        jl cautare_caracter

    ; Afisam mesajul de gasire a caracterului
    mov ah, 09h
    lea dx, [mesaj_gasit]
    int 21h

    ; Afisam valoarea contorului
    mov ah, 0Eh
    mov al, contor
    add al, 30h
    int 10h

ret
