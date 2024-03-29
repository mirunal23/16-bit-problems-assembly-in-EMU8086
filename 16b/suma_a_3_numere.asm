;  Suma a 3 numere  

org 100h
.data          
a db ?
b db ?
c db ?
suma db ?
msg db 10,13,'Suma acestora este: ', '$' 
msg1 db 'Primul numar este: ',  '$'   
msg2 db 10, 13,'Al doilea numar este: ', '$'
msg3 db 10,13,'Al treilea numar este: ', '$'

.code 
mov DX, offset msg1
mov AH, 09h
int 21h 

mov ah,01h 
int 21h 

sub al,30h
mov a,al 


mov DX, offset msg2
mov AH, 09h
int 21h  

mov ah,01h  
int 21h        


sub al,30h 
mov b,al    
add al,a       

xchg ax, bx
 

mov DX, offset msg3
mov AH, 09h
int 21h  

mov ah,01h  
int 21h        


sub al,30h
mov c, al
add ax, bx

 mov suma, al

mov DX, offset msg
mov AH, 09h
int 21h

mov al, suma
add al,30h          

mov ah,0Eh    
int 10h       



ret