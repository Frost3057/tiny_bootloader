start:
    mov ax,0x7C0
    mov ds,as

    mov ax,0x7E0
    mov ss,ax

    mov sp,0x2000

clearscreen:
    push bp
    mov bp,sp
    pusha
    mov ah,0x07 ;this tells the bios to scroll the window down
    mov 

