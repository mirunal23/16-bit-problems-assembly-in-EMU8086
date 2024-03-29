;Sa se afiseze dintr-o succesiune de cifre, doar cifrele cuprinse intre 5 si 9

mov ah,0
mov al,2
int 10h
lea dx,sir
mov ah,9
int 21h
mov cx,0
mov si,0
et1: mov ah,1
int 21h
cmp al,0dh
je et2
mov vect[si],al
inc cx
inc si
jmp et1
et2: mov ah,2
mov bh,0
mov dh,1
mov dl,0
int 10h
mov si,0
et4:
mov al,vect[si]
cmp al,38h ; nu va lua 9 merge pana la 8
jg et5 ;de aici se pot seta limitele
cmp al,36h ; nu va lua si 5 se opreste la 6
jb et5
mov ah,0eh
int 10h
et5: inc si
loop et4
ret
sir db "Introduceti succesiunea : $"
vect db 20 dup(?)