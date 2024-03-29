;Suma elementelor unui sir

org 100h
.data
sir db 1,4,1
suma dw ?
sir1 db " Suma este: $ "

.code
mov AX,0
mov AL, [sir+0]
add AL, [sir+1]
adc AH, 0
add AL, [sir+2]
adc AH, 0
mov suma, AX 
mov dx, offset sir1
mov ah,09h
int 21h  

mov ax, suma
add al,30h          

mov ah,0Eh    
int 10h
ret