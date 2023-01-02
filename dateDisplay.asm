;输出有符号数
DATA SEGMENT                		;数据段代码
	S1        db '20','$'
	Monday    db 'Monday','$'
	Tuesday   db 'Tuesday','$'
	Wednesday db 'Wednesday','$'
	Thursday  db 'Thursday','$'
	Friday    db 'Friday','$'
	Saturday  db 'Saturday','$'
	Sunday    db 'Sunday','$'
DATA    ENDS   
STACK SEGMENT		;堆栈段代码
STACK   ENDS
CODE SEGMENT                            		;代码段代码
	       ASSUME DS:DATA, SS:STACK, CS:CODE
	START: 
	       MOV    AX, DATA
	       MOV    DS, AX
	;年
	       LEA    DX, S1
	       MOV    AH, 9
	       INT    21H
	       mov    al,9
	       out    70h,al
	       in     al,71h
	       mov    ah,0
	       call   OUTBCD
	
	       mov    dl,'/'                    	;输出斜杠
	       mov    ah,2
	       int    21h
	;月
	       mov    al,8
	       out    70h,al
	       in     al,71h
	       mov    ah,0
	       call   OUTBCD
	
	       mov    dl,'/'                    	;输出斜杠
	       mov    ah,2
	       int    21h
	;日
	       mov    al,7
	       out    70h,al
	       in     al,71h
	       mov    ah,0
	       call   OUTBCD
	
	       mov    dl,' '                    	;输出空格
	       mov    ah,2
	       int    21h
	;时
	       mov    al,4
	       out    70h,al
	       in     al,71h
	       mov    ah,0
	       call   OUTBCD
	
	       mov    dl,':'                    	;输出空格
	       mov    ah,2
	       int    21h
	;分
	       mov    al,2
	       out    70h,al
	       in     al,71h
	       mov    ah,0
	       call   OUTBCD
	
	       mov    dl,':'                    	;输出空格
	       mov    ah,2
	       int    21h
	;秒
	       mov    al,0
	       out    70h,al
	       in     al,71h
	       mov    ah,0
	       call   OUTBCD
	       mov    dl,' '                    	;输出空格
	       mov    ah,2
	       int    21h
	;星期,注意周日是第一天
	       mov    al,6
	       out    70h,al
	       in     al,71h
	       mov    ah,0
	       cmp    al,1
	       je     O7
	       cmp    al,2
	       je     O1
	       cmp    al,3
	       je     O2
	       cmp    al,4
	       je     O3
	       cmp    al,5
	       je     O4
	       cmp    al,6
	       je     O5
	       cmp    al,7
	       je     O6
	O1:    
	       LEA    DX, Monday
	       MOV    AH, 9
	       INT    21H
	       jmp    E
	O2:    
	       LEA    DX, Tuesday
	       MOV    AH, 9
	       INT    21H
	       jmp    E
	O3:    
	       LEA    DX, Wednesday
	       MOV    AH, 9
	       INT    21H
	       jmp    E
	O4:    
	       LEA    DX, Thursday
	       MOV    AH, 9
	       INT    21H
	       jmp    E
	O5:    
	       LEA    DX, Friday
	       MOV    AH, 9
	       INT    21H
	       jmp    E
	O6:    
	       LEA    DX, Saturday
	       MOV    AH, 9
	       INT    21H
	       jmp    E
	O7:    
	       LEA    DX, Sunday
	       MOV    AH, 9
	       INT    21H
	       jmp    E
	E:     
	;返回DOS
	       MOV    AH, 4CH
	       INT    21H
	
	;输出压缩BCD码
OUTBCD proc
	       push   ax
	       and    al,0f0H
	       mov    cl,4
	       SHR    ax,cl
	       call   OUTPUT
	       pop    ax
	       mov    ah,0
	       and    al,0fh
	       call   OUTPUT
	       ret                              	;记得return emm....
OUTBCD endp
	;输出ax中的数
OUTPUT proc
	       mov    si,0                      	;bx bp si di
	       push   ax                        	;保护ax
	       push   bx
	       mov    bx,10
           
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
	       pop    bx
	       pop    ax                        	;还原ax
	       ret
OUTPUT endp

CODE    ENDS

END START