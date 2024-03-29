;E(x)=(a*b+c):d-5*e

org 100h
.data
a db -60
b dw 150
c db -100
d db 200 
e dw -8

.code  
mov AL, [a] 
cbw
mov BX, [b]
imul BX   
            xchg AX, CX
            xchg BX, DX 
mov AL, [c]
cbw
cwd ; DX:AX
add AX, CX  
adc DX, BX      
            xchg CX, AX
mov AL, [d] 
cbw   
            xchg AX, CX
idiv CX 
mov BX, AX   
mov AX, [e]
mov CX, 5
imul CX   
            xchg AX, BX
            xchg DX, CX
cwd
sub AX, BX
sbb DX, CX   

ret