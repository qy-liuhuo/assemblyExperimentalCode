;输入输出一个字符串
DATA SEGMENT		;数据段代码
DATA    ENDS   
STACK SEGMENT		;堆栈段代码
STACK   ENDS
CODE SEGMENT                            		;代码段代码
	       ASSUME DS:DATA, SS:STACK, CS:CODE
	START: 
	       MOV    AX, DATA
	       MOV    DS, AX

	       mov    bl,10
	       mov    ax,1234
	       call   OUTPUT
	;返回DOS
	       MOV    AH, 4CH
	       INT    21H
	;输出ax中的数
OUTPUT proc
	       mov    si,0                      	;bx bp si di
	       push   ax                        	;保护ax
	       mov    dl,0ah                    	;输出换行
	       mov    ah,2
	       int    21h
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
	       pop    ax                        	;还原ax
	       ret
OUTPUT endp
CODE    ENDS

END START