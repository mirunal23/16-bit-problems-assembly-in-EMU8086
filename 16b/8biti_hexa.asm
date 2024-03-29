
    
    
org 100h 
 afisare macro
    mov ah,09h
    int 21h
    endm
.data      
tabela db '0123456789ABCDEF'
nr dw 0A12h
sirCifre db '0','0', '$'
msgi db 'Numarul pe 8 biti este: ','$'
msg db '(h)', '$' 

.code
  mov DX, offset msgi
  afisare    
  mov al,byte ptr nr[1]
  mov cx,0
  cmp al,0
  jz sf 
  
repeta:
  mov bl,16
  mov ah,0
  div bl  
  xchg al, ah
  mov bx, offset tabela    ;mov al,byte ptr nr
  xlat 
  mov bx, 1
  sub bx, cx
  mov sirCifre[bx], al     ; add sirCifre[bx], 30h
  xchg al, ah
  inc cx
  cmp al,0     
  jnz repeta 
  
      
sf:
  mov dx, offset sirCifre
  afisare   
  mov al,byte ptr nr
  mov cx,0
  cmp al,0
  jz sf  
  
repeta2: 
  mov bl,16
  mov ah,0
  div bl  
  xchg al, ah
  mov bx, offset tabela   ;mov al,byte ptr nr
  xlat 
  mov bx, 1
  sub bx, cx
  mov sirCifre[bx], al   ; add sirCifre[bx], 30h 
  xchg al, ah
  inc cx
  cmp al,0      
  jnz repeta2     
  
sf22:
  mov dx, offset sirCifre
  afisare   
              
  mov dx, offset msg
  afisare  

  
ret
    
    
