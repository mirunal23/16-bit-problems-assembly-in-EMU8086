; Program care citeste de la tastatura un nr, porneste din mijlocul ecranului si merge progresiv pe diagonale pentru a
; afisa caracterul colorat

org 100h

afisMsg macro msg
    mov ah, 09h
    lea dx, msg
    int 21h
endm

.data
    caracter db ?
    nr dw 0 
    culoare db 0B5h
    linia db 12
    coloana db 40
    msg_caracter db 'Introduceti un caracter: $'
    msg_nr db 10,13,'Introduceti un numar intre 0 si 9: $'
    msg_input_error db 10, 13, 'Numarul introdus nu este intre 0 si 9. Apasati orice tasta pentru a iesi.$'

.code   
start:                     ; secventa pentru curatarea ecranului
    mov ah, 0x00
    mov al, 0x03            ; text mode 80x25 16 colours
    int 0x10
    mov bh, 0               ; initializare pagina pentru afisare

    afisMsg msg_caracter
    call preiaCar
    mov [caracter], AL

    afisMsg msg_nr
    call preiaCar
    sub al, '0'
    mov byte ptr [nr], al
    
    mov CX, [nr]
    cmp CX, 0
    jl input_error
    cmp CX, 9
    jg input_error
    
    ; Daca CX este între 0 ?i 9, ruleaza programul normal
    jmp aplica

input_error: 
    afisMsg msg_input_error  ; Afi?eaza mesajul de eroare
    mov ah, 0
    int 16h
    jmp end_p 
    
aplica:                     ; aici vom aplica toate modificarile dorite
                            ; secventa pentru curatarea ecranului
 mov ah, 0x00
 mov al, 0x03               ; text mode 80x25 16 colours
 int 0x10
 mov BL,0
 mov CX, [nr]               ; nr de repetari ale buclei
                            ; punct de pornire
 mov DL,[coloana]           ; coloana initiala
 mov DH,[linia]             ; linia initiala  

bucla:
 push cx                    ; CX are rol dublu, de aceea trebuie salvat pe stiva
                            ; pozitionare cursor pe ecran
 add DL, BL                 ; adun la coloana un nr
 add DH, BL                 ; adun la linie un nr
 inc BL                     ; pentru cresterea progresiva, folosim un registru, de ex BL, care in bucla se incrementeaza
 mov AH,02h
 int 10h                    ; cursor

 push bx                    ; BX are rol dublu, de aceea trebuie salvat pe stiva
                            ; afisare caracter
 mov BX, 0h                 ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH, 09h
 mov BL,[culoare]
 mov CX, 1
 int 10h                    ; afisarea colorata a caracterului in pozitia cursorului
 pop bx
 pop cx
 loop bucla
                            ; repetam inca de 3 ori in celelalte directii
 mov BL,0
 mov CX, [nr]
 mov DL,[coloana]
 mov DH,[linia] 
 
 
bucla2:
 push cx
                            ; pozitionare cursor pe ecran

 sub DL, BL
 add DH, BL
 inc BL

 mov AH,02h
 int 10h                    ; cursor
 push bx
                            ; afisare caracter
 mov BX, 1h                 ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoare]
 mov CX,1
 int 10h                    ; afisarea colorata a caracterului
 pop bx
 pop cx
 loop bucla2

 mov BL,0
 mov CX, [nr]
 mov DL,[coloana]
 mov DH,[linia]
 
 
 
bucla3:
 push cx
                            ; pozitionare cursor pe ecran

 add DL, BL
 sub DH, BL
 inc BL

 mov AH,02h
 int 10h                    ; cursor
 push bx
                            ; afisare caracter
 mov BX, 1h                 ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoare]
 mov CX,1
 int 10h                    ; afisarea colorata a caracterului
 pop bx
 pop cx
 loop bucla3


 mov BL,0
 mov CX, [nr]
 mov DL,[coloana]
 mov DH,[linia] 
 
 
 
bucla4:
 push cx
                            ; pozitionare cursor pe ecran
 sub DL, BL
 sub DH, BL
 inc BL
 mov AH,02h
 int 10h                    ; cursor
 push bx
                            ; afisare caracter
 mov BX, 1h                 ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoare]
 mov CX,1
 int 10h                    ; afisarea colorata a caracterului
 pop bx
 pop cx
 loop bucla4


end_p:
ret
                            ; procedura pentru preluarea de la tastatura a unui caracter
preiaCar proc
 mov Ah, 01h
 int 21h
 ret
preiaCar endp 
