org 100h
; macrou pentru afisarea unui mesaj pe ecran
afisMsg macro
 mov AH,09h
 int 21h
endm
.data
msg0 db 'Tastati caracterul ce se doreste a fi afisat: ','$'
msgAp db 10,13,'Tastati nr de aparitii al caracterului ( 1 ... 9 ): ','$'
msgLin db 10,13,'Tastati linia unde sa apara caracterul ( 1 ... 9 ): ','$'
msgCol db 10,13,'Tastati coloana unde sa apara caracterul ( 1 ... 9 ): ','$'
msgErEr db 10,13, 'Repetati operatia !', '$'
msg1 db 10,13,'Tastati R, G sau B pentru a selecta culoarea de scriere a caracterului: ','$'
msgR db 10,13,' ROSIE ','$'
msgG db 10,13,' VERDE ','$'
msgB db 10,13,' ALBASTRA ','$'
msg2 db 'este culoarea selectata de dvs','$'
msgErCulScriere db 10,13,'Ceva nu a mers bine la selectarea culorii textului=>se patreaza valoarea anterioara', '$'
msgErCulFond db 10,13,'Ceva nu a mers bine la selectarea culorii fondului=>se patreaza valoarea anterioara', '$'
msgReia db 10,13,10,13,'Doriti sa reluati programul? y/n','$'
msg3 db 10,13,'Tastati R, G sau B pentru a selecta culoarea de background a caracterului: ','$'
caracter db ? ; caracterul ce se doreste a fi afisat se preia de la tastatura
nraparitii dw 0 ; nr de aparitii al caracterului se preia de la tastatura (1...9)
culoarea db 0F0h ; fond alb culoare de scriere , scris cu negru
linia db 0
coloana db 0     


.code
start:
; secventa pentru curatarea ecranului
 mov ah, 0x00
 mov al, 0x03 ; text mode 80x25 16 colours
 int 0x10

; afisarea mesajului pentru preluarea de la tastatura a caracterului de afisat
mov dx, offset msg0
afisMsg
; preia caracterul de la tastatura si il salveaza in memorie
call preiaCar
mov [caracter], AL
; afisarea mesajului pentru preluarea de la tastatura a nr de aparitii a caracterului pe ecran
 mov dx, offset msgAp
 call verifica09
 mov byte ptr [nraparitii], AL
; afisarea mesajului pentru preluarea de la tastatura a coloanei unde sa se afiseze caracterul
 mov dx, offset msgCol
 call verifica09
 mov byte ptr [coloana], AL

; afisarea mesajului pentru preluarea de la tastatura a liniei unde sa se afiseze caracterul
 mov dx, offset msgLin
 call verifica09
 mov byte ptr [linia], AL
; afisarea mesajului de modificare a culorii textului
 mov dx, offset msg1
 afisMsg
; preia o tasta de la tastatura
call preiaCar
; verifica tasta apasata si actualizeaza culoarea textului
mov BL, [culoarea]
cmp AL, 'R'
 jne etGB
 and BL,0F0h ; se pune masca cu biti de 1 (se pastreaza) pe bitii culorii de fond
 mov AL, 0Ch ; se impune culoarea de scriere ca fiind ROSIE
 or BL, AL ; se combina cele 2 (culoarea de fond si cea de scriere)
 mov [culoarea], BL ; salvam noua culoare in memorie
 mov dx, offset msgR ; se va afisa un mesaj cu optiunea aleasa
 jmp gataCulText ; a fost selectat R, deci nu mai verificam in continuare
; daca se ajunge aici, inseamna ca tasta apasata nu a fost R
etGB: cmp AL, 'G'
 jne etB
 and BL,0F0h
 mov AL, 0Ah
 or BL, AL
 mov [culoarea], BL
 mov dx, offset msgG
 jmp gataCulText
; daca se ajunge aici, inseamna ca tasta apasata nu a fost nici R, nici G
etB: cmp AL, 'B'
 jne etEr
 and BL,0F0h
 mov AL, 09h
 or BL, AL
 mov [culoarea], BL
 mov dx, offset msgB
 jmp gataCulText
; daca se ajunge aici, inseamna ca tasta apasata nu a fost nici R, nici G, nici B
etEr: mov DX, offset msgErCulScriere
 afisMsg
 jmp fond
; daca se ajunge aici, inseamna ca a fost una dintre R, G sau B
gataCulText: afisMsg
 mov DX, offset msg2 ; a doua jumtatate a mesajului pentru afisarea optiunii alese pt culoarea de scriere
 afisMsg
fond: ; modificarea culorii backgroundului
; afisarea mesajului de modificare a culorii textului
mov dx, offset msg3
 afisMsg
; preia o tasta de la tastatura
call preiaCar
; verifica tasta apasata si actualizeaza culoarea textului
mov BL, [culoarea]
cmp AL, 'R'
 jne etbGB
 and BL,0Fh
 mov AL, 0C0h
 or BL, AL
 mov [culoarea], BL
 mov dx, offset msgR
 jmp gataCulFond
etbGB: cmp AL, 'G'
 jne etbB
 and BL,0Fh
 mov AL, 0A0h
 or BL, AL
 mov [culoarea], BL
 mov dx, offset msgG
 jmp gataCulFond
etbB: cmp AL, 'B'
 jne etbEr
 and BL,0Fh
 mov AL, 090h
 or BL, AL
 mov [culoarea], BL
 mov dx, offset msgB
 jmp gataCulFond
etbEr: mov DX, offset msgErCulFond
 afisMsg
 jmp aplica

gataCulFond: afisMsg
 mov DX, offset msg2
 afisMsg



; aici vom aplica toate modificarile dorite
aplica:
 ; secventa pentru curatarea ecranului
 mov ah, 0x00
 mov al, 0x03 ; text mode 80x25 16 colours
 int 0x10
 ; pozitionare cursor pe ecran
 mov DL,[coloana] ; coloana
 mov DH,[linia] ; linia
 mov AH,02h
 int 10h ; cursor
 ; afisare caracter
 mov BX, 1h ; specificam si pagina din memoria video
 mov AL, [caracter]
 mov AH,09h
 mov BL,[culoarea]
 mov CX,[nraparitii]
 int 10h ; afisarea colorata a caracterului

 mov DX, offset msgReia
 afisMsg

 call preiaCar
 cmp AL, 'n'
 jZ ies

 jmp start
ies:
ret
; procedura pentru preluarea de la tastatura a unui caracter
preiaCar proc
 mov Ah, 01h
 int 21h
 ret
preiaCar endp
verifica09 proc
dinNouNrAp: afisMsg
 ; preia nr de aparitii si il salveaza in memorie
 call preiaCar
 cmp AL,'1'
 jl dinNouNrAp
 cmp AL,'9'
 jg dinNouNrAp
 ; daca se ajunge aici, s-a tastat corect un nr cuprins intre 1 si 9
 sub AL, 30h
 ret
verifica09 endp