org 100h

.data
    sir db 20 dup(0)         ; sirul pentru a stoca caracterele
    msg db 10,13,'Introduceti un numar par de caractere (intre 10 si 20): $'
    err_msg_nesuf db 10, 13, 'EROARE: Nu ati introdus destule caractere! $'
    err_msg_impar db 10,13, 'EROARE: Ati introdus un numar impar de caractere intre 10 si 20! $'

.code
    mov ah, 09h              
    lea dx, msg              
    int 21h

    mov SI, 0                      
    
citeste:
    mov ah, 01h              
    int 21h
    cmp al, 1Bh               ; verifica daca caracterul citit este ESC
    je  ies             

    mov [sir + SI], al        
    inc SI                   ; incrementeaza contorul

    cmp SI, 20                ; verifica daca s-au citit maxim 20 de caractere  
    je  lungime

    jmp citeste
ies:
lungime:
    cmp SI, 10                ; verifica daca s-au citit minim 10 caractere
    jl  nesuf    

    test SI, 1                
    jnz impar   

    ; acum sirul se afla in memoria la adresa 'sir', iar lungimea este in registrul 'SI'

    ; Adauga aici codul tau pentru a face ce doresti cu sirul

    jmp pa

impar:
    mov ah, 09h               
    lea dx, err_msg_impar     
    int 21h

    jmp pa           

nesuf:
    mov ah, 09h               
    lea dx, err_msg_nesuf     
    int 21h

    jmp pa


    ; aici poti trata cazul cand utilizatorul a apasat ESC

pa:                   
    ret