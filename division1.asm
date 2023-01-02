;输入输出一个字符串
DATA SEGMENT                		;数据段代码
	       begin byte 10
	BUFFER db    10,?,10 dup(49)	;预留20字节空间
DATA    ENDS   
STACK SEGMENT		;堆栈段代码
STACK   ENDS
CODE SEGMENT                           		;代码段代码
	      ASSUME DS:DATA, SS:STACK, CS:CODE
	START:
	      MOV    AX, DATA
	      MOV    DS, AX
	;要输出的数字
	      mov    ax,2559
	;用于buffer索引
	;mov    si,0                      	;bx bp si di
	;被除数为10
	      mov    cl,10
                            
	L0:   div    cl                        	;除
	      add    ah,48                     	;数字变为asc字符
	      mov    [si],ah                   	;把ah中的数字(余数)挪到buffer里面去
	      mov    ah,0                      	;清空ah
	      add    si,1                      	;si加一到下一个存储位置
	      cmp    al,0                      	;比较如果不相等回到L0开始下一次
	      jne    L0

	L1:   
	      mov    dl,[si-1]                 	;记得减一(因为上面多加了)
	      mov    ah,2
	      int    21h
	      sub    si,1
	      cmp    si,0                      	;如果比0大则继续循环
	      ja     L1
	;返回DOS
	      MOV    AH, 4CH
	      INT    21H
CODE    ENDS

END START
