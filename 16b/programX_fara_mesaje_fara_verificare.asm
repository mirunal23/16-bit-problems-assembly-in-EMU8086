; Program care citeste de la tastatura un nr, porneste din mijlocul ecranului si merge progresiv pe diagonale pentru a
; afisa caracterul colorat
; (aici nu sunt afisate nici mesaje si nici nu se verifica daca tasta apasata este intre 0...9)

org 100h
afisMsg macro              ; macrou pentru afisarea unui mesaj pe ecran
 mov AH,09h
 int 21h
 endm
.data
    caracter db ?          ; caracterul ce se doreste a fi afisat se preia de la tastatura
    nr dw 0                ; nr de aparitii al caracterului se preia de la tastatura (1...9)                   
    culoarea db 0B5h       ; culoare implicita
    linia db 12
    coloana db 40

.code
start:                     ; secventa pentru curatarea ecranului
    mov ah, 0x00           
    mov al, 0x03           ; text mode 80x25 16 colours
    int 0x10               


call preiaCar              ; preia caracterul de la tastatura si il salveaza in memorie
mov [caracter], AL

call preiaCar              ; preia numarul de la tastatura si il salveaza in memorie
sub AL, 30h
mov byte ptr [nr], AL


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
 mov BX, 1h                 ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
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
 mov BL,[culoarea]
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
 mov BL,[culoarea]
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
 mov BL,[culoarea]
 mov CX,1
 int 10h                    ; afisarea colorata a caracterului
 pop bx
 pop cx
loop bucla4

ret
                            ; procedura pentru preluarea de la tastatura a unui caracter
preiaCar proc
 mov Ah, 01h
 int 21h
 ret
preiaCar endp 