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
    mov al,0x00;clear the entire window
    mov cx,0x00; tells that the top left of the screen starts from (0,0)
    mov dh,0x18 ;18h = 24 rows of chars
    mov dl,0x4f ;4fh = 79 cols of chars

    popa 
    mov sp,bp
    ret
    

