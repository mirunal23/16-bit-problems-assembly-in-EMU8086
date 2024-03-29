;Verifica daca un sir de caractere este palindrom

org 100h 
 afisMsg macro
 mov AH,09h
 int 21h
 endm 
 
.data
sir db 'elefaccafele'
l EQU $-sir; l=5  
msgda db 'DA ','$'
msgnu db ,'NU ','$' 

.code
mov si, 0
mov di, l-1 

eti:
    mov al, sir[si]
    mov bl, sir[di]
    cmp al,bl
    jnE sf
    inc si
    dec di
    cmp si, di
    jl eti  
    mov dx, offset msgda
    afisMsg
    jmp ies
    sf:
    mov dx, offset msgnu
    afisMsg
    ies:
ret