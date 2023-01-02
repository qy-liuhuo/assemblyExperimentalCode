;输出有符号数
DATA SEGMENT        		;数据段代码
	S1   db 0AH, 0DH,'$'
DATA    ENDS   
STACK SEGMENT		;堆栈段代码
STACK   ENDS
CODE SEGMENT                             		;代码段代码
	        ASSUME DS:DATA, SS:STACK, CS:CODE
	START:  
	        MOV    AX, DATA
	        MOV    DS, AX
	        mov    ax,0ffffh
	        call   BOUTPUT
	        push   ax
	        LEA    DX, S1
	        MOV    AH, 9
	        INT    21H
	        pop    ax
	        call   HOUTPUT

	;返回DOS
	        MOV    AH, 4CH
	        INT    21H
	;输入一个数存到ax中去
    
BOUTPUT proc
	        push   bx                        	;保护bx
	        mov    bx,ax                     	;将ax转移到bx
	        push   ax                        	;保护ax
	        mov    cx,16

	L:      ROL    bx,1                      	;循环左移一位
	        mov    dx,bx                     	;移位结果存到dx中进行与运算保留最后一位
	        and    dx,0001h
	        add    dl,48                     	;数字转字符
	        mov    ah,2                      	;输出
	        int    21h
	        loop   L

	        mov    dl,'B'                    	;输出2进制标志
	        mov    ah,2
	        int    21h
	        pop    ax                        	;恢复
	        pop    bx
	        ret
BOUTPUT endp

HOUTPUT proc
	        push   bx                        	;保护bx
	        mov    bx,ax                     	;将ax转移到bx
	        push   ax                        	;保护ax
	        mov    cx,4
	        mov    cl,4                      	;一次移动四位

	L1:     ROL    bx,cl                     	;循环左移4位
	        mov    dx,bx                     	;移位结果存到dx中进行与运算保留最后4位
	        and    dx,000fh                  	;数字转字符
	        call   Hchar                     	;调用Hchar
	        loop   L1                        	;循环

	        mov    dl,'H'                    	;输出16进制标志
	        mov    ah,2
	        int    21h
	        pop    ax                        	;恢复
	        pop    bx
	        ret

HOUTPUT endp
	;输出单个16进制字符
Hchar proc
	        cmp    dl,10
	        jb     ol
	        jmp    oh
	ol:     
	        add    dl,48
	        mov    ah,2
	        int    21h
	        ret
	oh:     
	        add    dl,55
	        mov    ah,2
	        int    21h
	        ret
Hchar endp



CODE    ENDS

END START