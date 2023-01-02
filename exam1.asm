DATAS SEGMENT
	;此处输入数据段代码
DATAS ENDS

STACKS SEGMENT
	;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
	          ASSUME CS:CODES,DS:DATAS,SS:STACKS
	START:    
	          MOV    AX,DATAS
	          MOV    DS,AX
   
	          MOV    BX,1234                    	;入口参数
	          CALL   OUTPUT                     	;call调用参数
	
	          MOV    AH,4CH
	          INT    21H
	
OUTPUT PROC
	          push   ax
	          push   BX
	          push   cx
	          mov    ax,bx
	          mov    cl,10                      	;除数
	          mov    bl,0                       	;
	LDIV:     
	          div    cl
	          push   ax
	          add    bl,1
	          cmp    al,0
	          je     print
	          mov    ah,0
	          jmp    LDIV

	print:    
	          cmp    bl,0
	          je     OUTPUTEND
	          pop    dx
	          mov    dl,dh
	          add    dl,'0'
	          mov    ah,2
	          int    21h
	          sub    bl,1
	          jmp    print
	OUTPUTEND:
	          pop    cx
	          pop    bx
	          pop    ax
	          ret
OUTPUT endp
CODES ENDS
    END START
