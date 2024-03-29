org 100h
.data
msg1 db "Introduceti caractere pana la apasarea tastei #:", 10, 13, "$"

msg2 db 10, 13, "Prima litera mica din sir apare de ", "$"
msg3 db " ori", 10, 13, "$"

msg4 db "Au mai ramas ", "$"
msg5 db " litere mici", "$"

sir db 40 dup(0), "$"
sir2 db 40 dup(0), "$"

newline db 10, 13, "$"

ok db 0
lit db ?

cnt db 0
cnt2 db 0

len dw 0
len2 dw 0
 
.code

; "Introduceti caractere pana la apasarea tastei #:"
mov dx, offset msg1
mov ah, 09h
int 21h

mov si, 0

citire: mov ah, 01h
        int 21h
        mov sir[si], al
        inc si
        
        ; verific daca caracterul e in intervalul 'a'-'z' (97-122 in ASCII)
        cmp al, 'a' 
        jb nu ; JUMP BELOW: daca caracterul e sub 'a', sar direct la comparatia cu # si continui citirea
        cmp al, 'z'
        ja nu ; JUMP ABOVE: daca caracterul e peste 'z', ----------||-----------
        
        ; verific daca am mai preluat o data litera mica
        cmp ok, 0
        jne nu ; JUMP NOT EQUAL: ok nu e egal cu 0, sar la eticheta
        
        ; altfel, incrementez ok si preiau prima litera mica
        ; aceasta operatie se va face o singura data
        inc ok
        mov lit, al
        
        ; compar caracterul citit cu #, daca nu e # continui citirea, altfel am terminat
        nu: cmp al, 23h ;#       
            jne citire

; sterg # din sir
dec si ; si are valoarea egala cu lungimea sirului, ma pozitionez la si-1, pe #
mov sir[si], '$' ; inlocuiesc # cu $ care arata sfarsitul sirului
mov len, si ; preiau lungimea sirului fara #

; numar de cate ori apare prima litera mica
; simultan, inlocuiesc aparitiile literei cu *
mov si, 0
mov cx, len
call numarare
           
  
; "Prima litera mica din sir apare de "
mov dx, offset msg2
mov ah, 09h
int 21h

; numarul de aparitii
add cnt, 30h ; adaug 30h pentru a converti numarul in codul ASCII care ii corespunde      
; citire caracter din DL
mov dl, cnt
mov ah, 02h
int 21h       

; " ori"       
mov dx, offset msg3
mov ah, 09h
int 21h

; sirul modificat cu '*'
mov dx, offset sir
mov ah, 09h
int 21h

mov dx, offset newline
mov ah, 09h
int 21h

; creez un sir nou in care toate '*' sunt sterse 
mov si, 0   
mov cx, len
call sirnou

; afisez noul sir
mov dx, offset sir2
mov ah, 09h
int 21h

mov dx, offset newline
mov ah, 09h
int 21h
       
; numar cate litere mici au ramas in noul sir       
mov si, 0
mov cx, len2
call numarare2

; "Au mai ramas "
mov dx, offset msg4
mov ah, 09h
int 21h

; numarul de litere mici
add cnt2, 30h
mov dl, cnt2
mov ah, 02h
int 21h
 
; " litere mici"
mov dx, offset msg5
mov ah, 09h
int 21h

ret

; subrutine dupa ret
numarare proc
     
     et1: mov al, sir[si]
          cmp al, lit
          jne nu2 ; JUMP NOT EQUAL: daca al si lit nu sunt egale, sar la eticheta nu2
          ; daca am gasit litera cautata, incrementez numarul de aparitii si inlocuiesc litera din sir cu *
          inc cnt
          mov sir[si], '*'
          ; altfel, sar peste cele doua instructiuni si trec la urmatoarea litera din sir
          nu2: inc si
               loop et1
               
     ; sfarsesc subrutina cu ret si endp
     ret         
numarare endp

sirnou proc
    et2: mov al, sir[si]
         cmp al, '*' ; JUMP EQUAL: daca al si '*' sunt egale, sar la eticheta nu3
         je nu3 
         ; daca caracterul nu e egal cu '*', adaug caracterul la noul sir
         mov sir2[di], al ; folosesc indexul DI in paralel cu SI, DI creste doar cand adaug in sirul nou
         inc di  
         ; altfel, nu il adaug la sirul nou si trec la urmatoarea litera din sir
         nu3: inc si ; SI creste la fiecare iteratie a loop-ului
              loop et2
              
    ; preiau lungimea noului sir
    mov len2, di
    
    ret
sirnou endp

numarare2 proc
    et3: mov al, sir2[si]
         ; daca caracterul preluat nu e litera mica sar peste incrementare
         cmp al, 'a'
         jb nu4
         cmp al, 'z'
         ja nu4
         inc cnt2
         nu4: inc si 
              loop et3
   
   ret
numarare2 endp

