format binary as "img"
use16
org $7c00

xor ax,ax
mov es,ax
mov ds,ax
mov ss,ax
mov bp,$8000
mov sp,bp

push ds
pop es

mov ah,$0e
mov bx,welcome

printmsg:
mov al,[bx]
int $10
inc bx
cmp al,$0d
jne printmsg

mov bx,$7e00

mov ah,$02
mov al,$01
xor ch,ch
mov cl,$01
xor dh,dh
mov dl,$01
int $13

jmp bx

jmp $

welcome db "Welcome to Aaron DOS! Loading floppy...",$0a,$0d

times 510-($-$$) db $00
db $55,$aa