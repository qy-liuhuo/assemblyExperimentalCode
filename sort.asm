;输入输出一个字符串
DATA SEGMENT                                                     		;数据段代码
	BUFFER dw 20 dup(?)
	NUM    dw 2
	S1     db "please input the number you want input:", 0AH, 0DH,'$'
	S2     db "input:",'$'
	S3     db 0AH, 0DH,"before sort:",'$'
	S4     db 0AH, 0DH,"after sort:",'$'
DATA    ENDS   
STACK SEGMENT		;堆栈段代码
STACK   ENDS
CODE SEGMENT                            		;代码段代码
	       ASSUME DS:DATA, SS:STACK, CS:CODE
	START: 
	       MOV    AX, DATA
	       MOV    DS, AX
	;存放乘数和除数
	       mov    bl,10
	;输入待输入数量
	       LEA    DX, S1
	       MOV    AH, 9
	       INT    21H
	       call   INPUT
	       mov    NUM[0],ax                 	;把数量存在了NUM中
	       mov    di,0
	       mov    CX,NUM[0]                 	;cx计数器值为数字个数
	LI:                                     	;输入n个数字依次存到BUFFER里面去
	       call   INPUT
	       mov    BUFFER[di],ax
	       add    di,2
	       loop   LI
	;提示语输出
	       LEA    DX, S3
	       MOV    AH, 9
	       INT    21H
	       mov    CX,NUM[0]
	       mov    di,0
	LO1:                                    	;输出排序前的数字
	       mov    ax,BUFFER[di]
	       call   OUTPUT
	       add    di,2
	       loop   LO1
	       
	;调用排序程序
	       call   SORT
	;提示语输出
	       LEA    DX, S4
	       MOV    AH, 9
	       INT    21H
	       mov    CX,NUM[0]
	       mov    di,0

	LO2:                                    	;输出排序后的数字
	       mov    ax,BUFFER[di]
	       call   OUTPUT
	       add    di,2
	       loop   LO2
	;返回DOS
	       MOV    AH, 4CH
	       INT    21H
	;输入一个数存到ax中去
INPUT proc
	;输入提示
	       LEA    DX, S2
	       MOV    AH, 9
	       INT    21H
	;栈中先给个0
	       mov    dx,0
	       push   dx
	begin: 
	;输入
	       mov    ah,1
	       int    21h
	;比较
	       cmp    al,48
	       jb     L3
	       cmp    al,57
	       ja     L3
	;还原成数字
	       sub    al,48
	;存到dl
	       mov    dl,al
	;出栈到ax
	       pop    ax
	;乘法
	       mul    bl
	;dh置0
	       mov    dh,0
	;ax=ax+dx
	       add    ax,dx
	;压栈
	       push   ax
	       jmp    begin
	L3:    
	       pop    ax
	       ret
INPUT endp
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

SORT proc                               		;排序函数（冒泡）
	       mov    si,0                      	;数组指针
	       mov    di,0                      	;循环次数记录
	       mov    cx,NUM[0]
	       add    cx,NUM[0]
	       sub    cx,2                      	;di每次加2每一轮到最后应该是2*n-2
	L:     
	       mov    ax,BUFFER[di]
	       cmp    ax,BUFFER[di+2]
	       ja     swap
	       add    di,2
	       cmp    di,cx
	       jne    L
	       je     E
	       

	swap:  push   BUFFER[di]
	       push   BUFFER[di+2]
	       pop    BUFFER[di]
	       pop    BUFFER[di+2]
	       add    di,2
	       cmp    di,cx
	       jne    L
	       je     E

	E:     
	       mov    di,0
	       add    si,1
	       cmp    si,NUM[0]
	       jbe    L
	       ret
		   
SORT endp

CODE    ENDS

END START