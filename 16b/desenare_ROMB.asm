; Program care deseneaza un romb pe ecran
org 100h
; macrou pentru afisarea unui mesaj pe ecran
afisMsg macro
 mov AH,09h
 int 21h
endm

.data
caracter db '*'                 ; caracterul ce se doreste a fi afisat se preia de la tastatura
lungime dw 15
latime dw 7
culoarea db 0B5h                ; culoare implicita
linia db 12
coloana db 40

.code
start:
                                ; secventa pentru curatarea ecranului
 mov ah, 0x00
 mov al, 0x03                   ; text mode 80x25 16 colours
 int 0x10

                                ; aici vom aplica toate modificarile dorite
aplica:
                                ; secventa pentru curatarea ecranului
 mov ah, 0x00
 mov al, 0x03                   ; text mode 80x25 16 colours
 int 0x10

                                ; desenare romb
 mov DL,[coloana]
 mov DH,[linia]
 mov CX,[latime]
 dec Dl
 inc dh 
 
bucla1:
 push cx
                                ; pozitionare cursor pe ecran
 dec DH                         ; cobor pe latime
 inc DL
 mov AH,02h
 int 10h                        ; cursor
                                ; afisare caracter
 mov BX, 1h                     ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
 int 10h                        ; afisarea colorata a caracterului
 pop cx
 loop bucla1

                                ; desenare romb, parte stanga
 mov DL,[coloana]
 mov DH,[linia]
 mov CX,[latime]
 dec dl
 dec dh 
 
 
bucla2:
 push cx
                                ; pozitionare cursor pe ecran
 inc DL
 inc DH
 mov AH,02h
 int 10h                        ; cursor
                                ; afisare caracter
 mov BX, 1h                     ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
 int 10h                        ; afisarea colorata a caracterului
 pop cx
 loop bucla2

                                ; desenare romb, parte dreapta
 mov CX, [lungime]
 mov DL,[coloana]
 add dl, cl
 mov DH,[linia]
 mov CX, [latime]
 inc dh
 inc dl
 dec Dl
 dec Dl 
 
 
bucla3:
 push cx
                                ; pozitionare cursor pe ecran
 dec DH                         ; cobor pe latime
 dec DL
 mov AH,02h
 int 10h                        ; cursor
                                ; afisare caracter
 mov BX, 1h                     ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
 int 10h                        ; afisarea colorata a caracterului
 pop cx
 loop bucla3 

                                ; desenare romb, parte jos
 mov CX, [lungime]
 mov DL,[coloana]
 add dl, cl
 mov DH,[linia]
 mov CX, [latime]
 dec dl 
 inc dh
 
bucla4:
 push cx
                                ; pozitionare cursor pe ecran
 inc DH                         ; cobor pe latime
 dec DL
 mov AH,02h
 int 10h                        ; cursor
                                ; afisare caracter
 mov BX, 1h                     ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,1
 int 10h                        ; afisarea colorata a caracterului
 pop cx
 loop bucla4  
 

ret
                                ; procedura pentru preluarea de la tastatura a unui caracter
 preiaCar proc
 mov Ah, 01h
 int 21h
 ret
 preiaCar endp