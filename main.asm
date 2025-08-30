start:
    mov ax,0x7C0
    mov ds,as

    mov ax,0x7E0
    mov ss,ax

    mov sp,0x2000

clearscreen:
;Overhead :
    push bp ;we are saving the caller's base pointer
    mov bp,sp ;and now we are updating the base pointer with a stack pointer
    pusha ;push all the register on the stack
;code:
    mov ah,0x07 ;this tells the bios to scroll the window down
    mov al,0x00;clear the entire window
    mov cx,0x00; tells that the top left of the screen starts from (0,0)
    mov dh,0x18 ;18h = 24 rows of chars
    mov dl,0x4f ;4fh = 79 cols of chars
    int 0x10 ;calls video interrupt
;Overhead : 
    ;mirroring the process that we did in the first overhead.
    popa ;pop all the registers of the stack
    mov sp,bp
    pop bp
    ret
movecursor:
    push bp
    mov bp,sp
    pusha

    mov dx, [bp+4] ; get the arguement from the stack.
    mov ah, 0x02 ;set cursor position
    mov bh, 0x00 ;page - 0 =>doesn't matter for now as we are not using double buffer

    popa
    mov sp,bp
    pop bp
    ret




