; Sa se scrie un text de 20 de caractere (ASCII) in memorie, incepand cu 
; adresa 07102h. Sa se afiseze textul pe ecran folosind afisarea individuala 

org 100h
.data
sir db 'Ana are mere'
l equ $-sir

.code
mov SI, offset sir
mov CX, l
start:
        mov AL, [SI]
        mov AH, 0Eh
        mov BH, 0
        int 10h
        inc SI
        loop start
        
ret