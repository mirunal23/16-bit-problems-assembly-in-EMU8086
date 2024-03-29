; De la tastatura se citeste R/G/B si se modifica culoarea textului 
; de scriere a caracterului in functie de acesata optiune

org 100h ; p2_05_1       

afismsg macro
mov ah, 09h
int 21h
endm   

.data   

a db ?
msg1 db ,10,13, 'Introduceti primul numar $'
b db ? 
msg2 db ,10,13, 'Introduceti al doilea numar $'
suma db ? 
msg db ,10,13, 'Cum vrei sa se afisez rezultatul? Apasa n-necolorat, c-colorat',10,13, '$'     
msg3 db ,10,13, 'Mai vrei sa ruleze programul? y-yes, n-no' ,10,13, '$'         


.code  

start:
 
mov dx, offset msg1
afismsg
call citeste
mov a,al 
 
mov dx, offset msg2
afismsg        
call citeste   
mov b,al    
  
add al, a 
mov suma,al 
  
mov dx, offset msg
afismsg  

call citeste

add al, 30h
cmp al, 'n'
jne nu
mov al, suma 

call afiseaza
jmp comun
nu: 
cmp al, 'c'
jne comun
mov al, suma 

call afisare 
 
comun:
 
    mov dx, offset msg3
    afismsg    
    call citeste

add al, 30h
cmp al, 'n'
je ies  
cmp al, 'y'
je start
mov al, suma 
ies:

     mov dx, offset msg3
     afismsg         
     call start 


call afisare  
 

ret        

citeste proc
mov AH, 01h
int 21h
sub AL, 30h

ret
citeste endp   

afiseaza proc      

add al,30h 
mov ah,0Eh 
int 10h


afiseaza  endp 

afisare proc  
mov dl, 45 
mov dh, 15 
mov ah, 02h
int 10h 

add al, 30h
mov ah, 09h
mov bl, 00001100b
mov cx, 1
int 10h  
afisare endp
ret     

                                              
                                                 