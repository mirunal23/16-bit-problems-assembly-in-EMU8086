;Sa se compare doua numere definite in memorie pe octet. 
;Dupa fiecare situatie se va afisa mesajul pe ecran        
; PENTRU NUMERE UNSIGNED

org 100h
.data 
a db 7Fh
b db 80h
msg1 db 'primul numar este mai mic ca al doilea numar (a < b) ' , '$'
msg2 db 'primul numar este mai mare sau egal ca al doilea numar (a >= b) ' , '$'

.code                
mov AL, a
cmp AL, b
jge et2
lea DX, msg1
jmp et3   

et2: 
    lea DX, msg2
    
et3:
    mov AH, 09h
    int 21h
ret