;se citeste o succesiune de litere si cifre; sa se afiseze pe 
;randul 1 cifrele pare si pe randul 2 cifrele impare

mov ah,0
mov al,2
int 10h
lea dx,sir
mov ah,9
int 21h
mov si,0
mov cx,0
et3:mov ah,1
int 21h
cmp al,0dh
je et4
cmp al,39h
jg et3
mov vect[si],al
inc si
inc cx
jmp et3
et4: mov si,0
mov dl,0
mov dh,1
et5:xor ax,ax
mov al,vect[si]
mov bl,2
div bl
cmp ah,0
jne et9
mov ah,2
mov bh,0
int 10h
inc dl
mov al,vect[si]
mov ah,0eh
int 10h
et9: inc si
loop et5
et6:mov cx,si ; reinitializez contor pentru vect
mov si,0 ;reincarc nr de elemente
mov dl,0
mov dh,2
et7: xor ax,ax
mov al,vect[si]
mov bl,2
div bl
cmp ah,0
je et8
mov ah,2
mov bh,0
int 10h
inc dl
mov al,vect[si]
mov ah,0eh
int 10h
et8:
inc si
loop et7
ret
sir db "Introduceti succesiunea : $"
vect db 20 dup(?)