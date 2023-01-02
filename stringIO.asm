;输入输出一个字符串
DATA SEGMENT           		;数据段代码
	BUFFER DB 20           	;预留20字节空间
	       DB ?            	;输入完成后，自动获得输入的字符个数
	       DB 20 DUP(0)
	CRLF   DB 0AH, 0DH, '$'	;回车符
DATA    ENDS           
STACK SEGMENT     		;堆栈段代码
	      DW 20 DUP(0)
STACK   ENDS
CODE SEGMENT                           		;代码段代码
	      ASSUME DS:DATA, SS:STACK, CS:CODE
	START:
	      MOV    AX, DATA
	      MOV    DS, AX
	;输入字符串到DX
	      LEA    DX, BUFFER
	      MOV    AH, 0AH                   	;从键盘输入一个字符串到指定缓冲区
	      INT    21H
	;在字符串末尾添加字符串结尾标志符
	      MOV    AL, BUFFER+1
	      ADD    AL, 2
	      MOV    AH, 0
	      MOV    SI, AX
	      MOV    BUFFER[SI], '$'
	;输出换行
	      LEA    DX, CRLF
	      MOV    AH, 9
	      INT    21H
	;输出刚刚输入的字符串
	      LEA    DX, BUFFER+2
	      MOV    AH, 9
	      INT    21H
	;尝试输出第一位
	      mov    al,BUFFER[0]
	      mov    ah,0
	      mov    cl,10
	      div    cl
	      mov    dl,ah
	      add    dl,48
	      mov    ah,2
	      int    21h
	;返回DOS
	      MOV    AH, 4CH
	      INT    21H
CODE    ENDS                        ;退出DOS状态
        END START
