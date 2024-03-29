;E(x)=(a*b+c):d-5*e

org 100h
.data
a db 60
b dw 150
c db 100
d db 200 
e dw 8

.code  
mov AH,0
mov AL, [a]
mov BX, [b]
mul BX     ;AX*BX => DX:AX= 0000h:2328h
mov BX, 0
mov CH, 0
mov CL, [c]
add AX, CX  
adc DX, BX    ;DX:AX = 0000h:238Ch  
mov BH,0
mov BL, [d]
div BX ; DX:AX= 0000h:002Dh
mov BX, AX   ; BX=002Dh
mov AX, [e]
mov CX, 5
mul CX   ; DX:AX= 0000h:0028h
mov CX, 0
sub BX, AX
sbb CX, DX   ; CX:BX= 0000h:0005h

ret