; Program care deseneaza un dreptunghi pe ecran
org 100h
; macrou pentru afisarea unui mesaj pe ecran
afisMsg macro
 mov AH,09h
 int 21h
endm
.data
caracter db '*' ; caracterul ce se doreste a fi afisat se preia de la tastatura
lungime dw 15
latime dw 6
culoarea db 0B5h ; culoare implicita
linia db 12
coloana db 40
.code
start:
; secventa pentru curatarea ecranului
 mov ah, 0x00
 mov al, 0x03 ; text mode 80x25 16 colours
 int 0x10

; aici vom aplica toate modificarile dorite
aplica:
 ; secventa pentru curatarea ecranului
 mov ah, 0x00
 mov al, 0x03 ; text mode 80x25 16 colours
 int 0x10
 ;mov BL,0
 mov CX, [lungime] ; nr de repetari ale buclei
 ; punct de pornire
 mov DL,[coloana]
 dec DL ; coloana initiala
 mov DH,[linia] ; linia initiala
bucla:
 push cx ; CX are rol dublu, de aceea trebuie salvat pe stiva
 ; pozitionare cursor pe ecran
 add DL, 1 ; incrementez coloana (se creeaza latura lunga)
 mov AH,02h
 int 10h ; cursor
 ; afisare caracter
 mov BX, 1h ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
 int 10h ; afisarea colorata a caracterului in pozitia cursorului
 pop cx
loop bucla
; repetam inca de 3 ori pt celelalte laturi
 ;mov BL,0
 mov CX, [latime]
 mov DL,[coloana]
 mov DH,[linia]
 dec DH
bucla2:
 push cx
 ; pozitionare cursor pe ecran

 inc DH ; cobor pe latime

 mov AH,02h
 int 10h ; cursor

 ; afisare caracter
 mov BX, 1h ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
 int 10h ; afisarea colorata a caracterului
 pop cx
loop bucla2


 mov CX, [lungime]
 mov DL,[coloana] ; la coord de coloana a punctului de origine, adun o lungime
 add DL, CL
 dec DL
 mov DH,[linia]
 dec DH
 mov CX, [latime]
bucla3:
 push cx
 ; pozitionare cursor pe ecran

 inc DH

 mov AH,02h
 int 10h ; cursor
 ; afisare caracter
 mov BX, 1h ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
 int 10h ; afisarea colorata a caracterului
 pop cx
loop bucla3


 mov CX, [latime]
 mov DL,[coloana] ; la coord de coloana a punctului de origine, adun o lungime

 mov DH,[linia]
 add DH, CL
 dec DH
 dec DL
 mov CX, [lungime]
bucla4:
 push cx
 ; pozitionare cursor pe ecran

 inc DL
 mov AH,02h
 int 10h ; cursor
 ; afisare caracter
 mov BX, 1h ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
 int 10h ; afisarea colorata a caracterului

 pop cx
loop bucla4


ret
; procedura pentru preluarea de la tastatura a unui caracter
preiaCar proc
 mov Ah, 01h
 int 21h
 ret
preiaCar endp 