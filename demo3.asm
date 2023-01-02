DATAS SEGMENT
	buffer db 10,?,10 dup(?)
DATAS ENDS

STACKS SEGMENT
	;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
	      ASSUME CS:CODES,DS:DATAS,SS:STACKS
	START:
	      MOV    AX,DATAS
	      MOV    DS,AX
    
	      mov    ax,2559
	      mov    bl,10
	      mov    si,1
    
	L0:   div    bl
	      add    ah,48
	      mov    buffer[si],ah
	      mov    ah,0
	      add    si,1
	      cmp    al,0
	      jne    L0
 	
	L1:   
	      mov    dl,buffer[si-1]
	      mov    ah,2
	      int    21h
	      sub    si,1                       	;di,si,bx,bp基础寄存器
	      cmp    si,1
	      ja     L1
    
	      MOV    AH,4CH
	      INT    21H
CODES ENDS
    END START
