org 100h
afisMsg macro msg
    mov ah, 09h
    lea dx, msg
    int 21h
endm

.data
sir db 255 DUP(0)   ; aloca spatiu pentru un sir de maxim 255 de caractere
suma dw ?
sir1 db " Tasteaza elementele sirului pana la apasarea tastei ESC $ "
msg1 db ,10,13, 'Cum vrei sa se afisez rezultatul? Apasa n-necolorat, c-colorat','$'
sir2 db 10,13, " Suma este $ " 
msg2  db 10,13, "Doriti sa introduceti alt sir? y/n: $"

.code 
afisMsg sir1
call preiaCar 

mov SI, offset sir
sub al, 30h
mov [SI], al 
inc SI 

start: 
    mov ah,01h 
    int 21h                                           
    cmp AL, 1Bh        ; verifica daca este tasta ESC
    je ies  
    
    sub al, 30h
    mov [SI], al 
    inc SI
    jmp start 

ies:    
    mov AX, 0 
    mov SI, 0           ; Resetarea indexului la inceputul sirului 
    mov BX, offset sir
    add AL, [BX+SI]       
    mov CX, 254

eti: 
    inc SI
    add AL, [BX+SI]
    adc ah, 0
    loop eti 
    mov suma, ax 
 
      
    afisMsg msg1
    call preiaCar

add al, 30h
cmp al, 'n'
jne nu
mov ax, suma 

call afisare
jmp comun

nu: 
cmp al, 'c'
jne comun
mov ax, suma 


call afisare

comun:

    afisMsg sir2
    mov ax, suma
    add al, 30h           

    mov ah, 0Eh    
    int 10h
    afismsg msg2
    call preiaCar

add al, 30h
cmp al, 'n'
je pa  
cmp al, 'y'
je start
mov ax, suma 
        
call start 
call afisare

 
pa: 

ret

 ; procedura pentru preluarea de la tastatura a unui caracter
 preiaCar proc
 mov Ah, 01h
 int 21h
 ret
 preiaCar endp        
    


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
