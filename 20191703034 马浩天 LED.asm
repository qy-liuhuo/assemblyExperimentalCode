DATA SEGMENT
    ;led中存储显示对应编码 0-->0c0h 1---> 0f9h ............ 
	LED  DB 0c0H,0F9H,0a4h,99h,92h,82h,0f8h,80h,90h
	     db 88h,83h,0c6h,0a1h,86h,8eh
DATA ENDS

cs8255 EQU 0303h
porta equ 0300h
portb equ 0301h

code SEGMENT
    assume cs:code
START proc near
    mov dx,cs8255;配置工作方式
    mov al,80h
    out dx,al
main: 
    mov ah,1  ;等待输出
    int 21h
    sub al,48
    mov ah,0
    mov si,offset LED ;LED基地址
    add si,ax   ;加上偏移量
    mov al,[si] ;装载到al中

    mov dx,porta 
    out dx,al ;输出到porta

    mov al,0000001B ;初始化al
    mov cx,6
L:  ;循环左移一次电亮led
    rol al,1
    mov dx,portb
    out dx,al
    call delay
    loop L

    jmp main
START endp

delay proc ;延时函数
    push ax
    push bx
    push cx
    push dx
    mov cx,50000
L0:
    dec cx
    cmp cx,0
    jne L0

    pop dx
    pop cx
    pop bx
    pop ax
    ret 
delay endp
