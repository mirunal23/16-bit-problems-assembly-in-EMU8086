; Suma a 2 numere

org 100h
.data
a db ?
b db ?     
suma db ?
sir1 db " Tasteaza primul numar $ "
sir2 db 10,13, " Tasteaza al doilea numar $ "
sir3 db 10,13, " Suma este $ "
                                                        
.code                                         
mov dx, offset sir1
mov ah,09h
int 21h
                                          
mov ah,01h 
int 21h 

sub al,30h
mov a,al 
  
mov dx, offset sir2
mov ah,09h
int 21h

mov ah,01h  
int 21h        

sub al,30h 
mov b,al    
add al,a       

mov suma,al  

mov dx, offset sir3
mov ah,09h
int 21h  

mov al, suma
add al,30h          

mov ah,0Eh    
int 10h       

ret









