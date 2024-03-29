;Verifica de cate ori apare un caracter intr-un sir

org 100h

.data
  contor db 0
  sir db 'Acesta este un sir de caractere', '$'
  l equ $-sir-1
  car db 's'

.code
     mov SI, 0
     mov AL, car
     mov CX, l      ; Utilizam CX pentru obtine lungimea sirului
  
start:
     cmp AL, [sir + SI]
     jne ies
     inc contor ; Daca am gasit caracterul, incrementam contorul

ies:
    inc SI
    loop start

  
mov AH, 0Eh  ; Afisam contorul
mov AL, contor
add AL, 30h
int 10h

ret