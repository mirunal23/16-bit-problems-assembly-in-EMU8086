org 100h

.data
sir db 50 dup (0)   
suma db ?
sir1 db " Tasteaza cifre si cand e gata, apasa ESC $"
                                                        
.code                                         
mov dx, offset sir1
mov ah,09h
int 21h   


mov SI, offset sir
start:                                           
mov ah,01h 
int 21h  

    cmp AL, 1Bh 
    je ies  
    
    sub al,30h
mov [SI] ,al 
inc SI
    jmp start
  
  ies:  
    
    
     

ret









