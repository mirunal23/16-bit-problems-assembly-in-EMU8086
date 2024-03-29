;Suma elementelor unui sir

org 100h
.data
sir db 255 DUP(0)  ; aloca spatiu pentru un sir de maxim 255 de caractere     
suma dw ?
sir1 db " Tasteaza elementele sirului pana la apasarea tastei ESC $ "
sir2 db 10,13, " Suma este $ "

.code 
mov dx, offset sir1
mov ah,09h
int 21h
                                          
mov ah,01h 
int 21h 

mov SI, offset sir
sub al,30h
mov [SI] ,al 
inc SI 


start:                                           
mov ah,01h 
int 21h  

cmp AL, 1Bh        ; verifica daca este tasta ESC
je ies  
    
sub al,30h
mov [SI] ,al 
inc SI
jmp start 

ies:    
mov AX, 0 
mov SI, 0           ; Resetarea indexului la inceputul sirului 
mov BX, offset sir
add AL, [BX+SI]       
mov CX, 254

eti: 
inc si
add AL, [BX+SI]
adc ah, 0
loop eti 
mov suma, ax
 
mov dx, offset sir2
mov ah,09h
int 21h  

mov ax, suma
add al,30h          

mov ah,0Eh    
int 10h 


ret