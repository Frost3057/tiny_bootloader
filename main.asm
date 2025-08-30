bits 16
;the bootloader loads its data from the rom to ram at position 0x7c0
mov ax,0x7C0
mov ds,as
;the stack segment starts just after the boot segment which is of 512 bytes.
mov ax,0x7E0
mov ss,ax
;now here the stack pointer generally downgrades on each addition and we want a 8kb stack segment therefore we will use the address
;0x2000 for the stack pointer
mov sp,0x2000

call clearscreen
push 0x0000

call movecursor
add sp,2

push msg
call print
add sp,2

cli
hlt
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
;the 0 at the end works as a null character which can be used to terminate the string.
msg: db "Oh boy this is tough!",0
print:
    push bp
    mov bp,sp
    pusha
    mov si,[bp+4] ;get pointer to the data
    mov bh,0x00 ;page number,not required here
    mov bl,0x00 ;foreground color
    mov ah,0x0eh ;print char to ttv
.char:
    mov al,[si] ;get the character from the index
    add si,1
    or al,0
    je .return
    int 0x10 ;print the character if we are not done
    jmp .char
.return:
    popa
    mov sp,bp
    pop bp
    ret

times 510-(\$-$$) db 0
dw 0xAA55

