;输出有符号数
DATA SEGMENT		;数据段代码

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

	; mov    ax,-123                   	;ax存储
	       mov    ax,123
	       cmp    ax,0                      	;和0进行有符号数比较
	       JL     N
	       jmp    OU
	N:                                      	;负数处理
	       push   ax                        	;保护ax
	       mov    dl,2DH                    	;输出-号
	       mov    ah,2
	       int    21h
	       pop    ax                        	;还原ax
	       neg    ax                        	;求补
	       jmp    OU                        	;输出绝对值

	OU:    
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