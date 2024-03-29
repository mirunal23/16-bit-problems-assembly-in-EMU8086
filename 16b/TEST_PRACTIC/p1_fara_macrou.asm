;Se citesc de la tastatura 2 caractere litera (intre A si Z), precedate de
;un mesaj corespunzator. Sa se verifice care dintre ele apare primul in alfabet 
;si sa se afiseze acest caracter pe ecran, de asemena procedat de un mesaj coresp

org 100h

.data 
    a db ?
    b db ?
    msg1 db 'Introduceti primul caracter: $'
    msg2 db 10, 13,'Introduceti al doilea caracter: $'
    msg3 db 10, 13,'Primul caracter in ordine alfabetica: $' 
    msg_er db 10,13, 'Nu ati introdus o litera sau nu este o litera mare! $'

.code
  ; Citire primul caracter
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov a, al

    ; Verificare daca primul caracter este o litera
    mov al, a
    cmp al, 'A'
    jl eroare
    cmp al, 'Z'
    jg eroare
    jmp citire

eroare:
    ; Afisarea mesajului de eroare
    mov dx, offset msg_er
    mov ah, 09h
    int 21h
    jmp ies

citire:
    ; Citire al doilea caracter
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov b, al

    ; Verificare daca al doilea caracter este o litera
    mov al, b
    cmp al, 'A'
    jl eroare
    cmp al, 'Z'
    jg eroare

    ; Verificare ordine alfabetica ?i afi?are rezultat
    mov al, a
    mov bl, b
    cmp al, bl
    jl caract1
    jg caract2

caract1:
    ; Afisarea primului caracter
    mov dx, offset msg3
    mov ah, 09h
    int 21h

    mov dl, a
    mov ah, 02h
    int 21h

    jmp ies

caract2:
    ; Afisarea celui de-al doilea caracter
    mov dx, offset msg3
    mov ah, 09h
    int 21h

    mov dl, b
    mov ah, 02h
    int 21h

ies:

ret