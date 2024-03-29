 ; Suma a 2 numere cu macrou

org 100h
afismsg macro
mov ah, 09h
int 21h
endm
.data
a db ?
b db ?     
suma db ?
sir1 db " Tasteaza primul numar $ "
sir2 db 10,13, " Tasteaza al doilea numar $ "
sir3 db 10,13, " Suma este $ "
                                                        
.code                                         
mov dx, offset sir1
afismsg
call citeste 

mov bl,al 
  
mov dx, offset sir2
afismsg
call citeste        
    
add al,bl       

mov suma,al  

mov dx, offset sir3
afismsg 

mov al, suma
add al,30h          

mov ah,0Eh    
int 10h       

ret
citeste proc
mov AH, 01h
int 21h
sub AL, 30h

ret
citeste endp 
      








