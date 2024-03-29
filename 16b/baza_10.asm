; Sa se scrie un program care sa determine cifrele nr aflate in AX in oricare din bazele 2, 10, 16.
; Cifrele se vor obtine folosing instr. aritmetice si se vor depune intr-o variabila sir de octeti
; din memorie


org 100h
.data
nr dw 12345
B equ 10   ;baza numarului  
sir db 5 DUP(0) 
l equ $-sir
tabela db '0123456789ABCDEF'

.code             
mov AX, nr
mov CX, 0
repeta:     
	mov BX, B ; pt baza 
	mov DX, 0 ; initializam cu 0 pt impartire
	div BX  ; cat AX, rest DX   
	mov BX, l-1   ; am controlat indexu din sir care este in sens invers
	sub BX, CX
	mov sir[BX], DL 
	inc CX
	cmp AX, 0
	jnZ repeta

afisare: 
	mov SI, l
	sub SI, CX 
    mov AL, sir[SI]
	mov AH, 0Eh
	mov BX, offset tabela
	xlat
	int 10h           ; afisare pe ecran
	loop afisare 
   
	
ret