DATAS SEGMENT
	A1    DB -123,-12,13,14,156,189,-111,-123,-234,-23
DATAS ENDS

STACKS SEGMENT
	;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
	         ASSUME CS:CODES,DS:DATAS,SS:STACKS
	START:   
	         MOV    AX,DATAS
	         MOV    DS,AX
    
	         MOV    BH,0                       	;计数器
	         MOV    CH,0                       	;正数
	         MOV    CL,0                       	;负数
	
	         MOV    SI,OFFSET A1
	FORBH:   
	         MOV    al,[SI]
	         AND    Al,10000000b
	         CMP    Al,0                       	;判正负数取最高位0正1负
	         JZ     ZHENGSHU                   	;0正1负
	         INC    CL
	AGAIN:   
	         INC    BH
	         INC    SI
	         CMP    BH,10
	         JZ     OVER
	         JMP    FORBH
	
	ZHENGSHU:
	         INC    CH
	         JMP    AGAIN
	
	OVER:    
	         MOV    DL,CH
	         ADD    DL,48
	         MOV    AH,2
	         INT    21H
	
	         MOV    DL,CL
	         ADD    DL,48
	         MOV    AH,2
	         INT    21H
	
	         MOV    AH,4CH
	         INT    21H
CODES ENDS
    END START
