; Sa se scrie un program care sa determine cifrele nr aflate in AX in oricare din bazele 2, 10, 16.
; Cifrele se vor obtine folosing instr. aritmetice si se vor depune intr-o variabila sir de octeti
; din memorie


org 100h
.data
nr dw 12345
B equ 2   ;baza numarului

.code             
mov AX, nr
mov CX, 0
repeta:     
	mov BX, B ; pt baza 
	mov DX, 0 ; initializam cu 0 pt impartire
	div BX  ; cat AX, rest DX   
	push DX 
	inc CX
	cmp AX, 0
	jnZ repeta

afisare: 
	pop BX 
    mov AL, BL
    add AL, 30h          ; ASCII
	mov AH, 0Eh
	int 10h           ; afisare pe ecran
	loop afisare 
   
	
ret
	
