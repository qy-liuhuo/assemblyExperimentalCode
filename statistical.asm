;输入输出一个字符串
DATA SEGMENT                                                		;数据段代码
	table  db 7,98,-98,158,10,133,-45,66,-134,-122,0,-33,0,-99,0
	S1     db "The number of positive numbers is:", '$'
	S2     db "The number of negative numbers is:", '$'
	S3     db "The number of zero is:",'$'
	BUFFER db 3 dup(0)
DATA    ENDS   
STACK SEGMENT		;堆栈段代码
STACK   ENDS
CODE SEGMENT                            		;代码段代码
	       ASSUME DS:DATA, SS:STACK, CS:CODE
	START: 
	       mov    bl,10
	       MOV    AX, DATA
	       MOV    DS, AX
	       mov    si,0
	L:     
	       cmp    table[si],0
	       je     Z
	;cmp    table[si],10000000b       	;负数以补码形式存储
	       JG     P
	       JL     N
	       
	Z:     
	       add    BUFFER[0],1
	       add    si,1
	       cmp    si,15
	       jb     L
	       jmp    ou
    
	P:     
	       add    BUFFER[1],1
	       add    si,1
	       cmp    si,15
	       jb     L
	       jmp    ou
	N:     
	       add    BUFFER[2],1
	       add    si,1
	       cmp    si,15
	       jb     L
	       jmp    ou
	ou:    
	       LEA    DX, S3
	       MOV    AH, 9
	       INT    21H

	       mov    ax,0
	       mov    al,BUFFER[0]
	       call   OUTPUT

	       LEA    DX, S1
	       MOV    AH, 9
	       INT    21H

	       mov    ax,0
	       mov    al,BUFFER[1]
	       call   OUTPUT

	       LEA    DX, S2
	       MOV    AH, 9
	       INT    21H

	       mov    ax,0
	       mov    al,BUFFER[2]
	       call   OUTPUT


	;返回DOS
	       MOV    AH, 4CH
	       INT    21H
	;输入一个数存到ax中去
    
OUTPUT proc
	       mov    si,0                      	;bx bp si di
	       push   ax                        	;保护ax
	       pop    ax                        	;还原ax
	       push   ax                        	;保护ax
	L0:    div    bl                        	;除
	       add    ah,48                     	;数字变为asc字符
	       push   ax                        	;ax入栈
	       mov    ah,0                      	;清空ah
	       add    si,1                      	;si加一到下一个存储位置
	       cmp    al,0                      	;比较如果不相等回到L0开始下一次
	       jne    L0

	L1:    
	       pop    dx                        	;出栈到dx
	       mov    dl,dh                     	;dh（有效结果）放到dl中去
	       mov    ah,2
	       int    21h
	       sub    si,1
	       cmp    si,0                      	;如果比0大则继续循环
	       ja     L1
	       mov    dl,0ah                    	;输出换行
	       mov    ah,2
	       int    21h
	       pop    ax                        	;还原ax
	       ret
OUTPUT endp

CODE    ENDS

END START