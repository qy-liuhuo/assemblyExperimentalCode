DATAS SEGMENT
	a1        db 12,2,113,4,5
	a2        dw 12,2,113,4,5
	srcstring db 'abcd'
	a3        db 'testtesttest'
DATAS ENDS

EXTRAS SEGMENT
	b1         db 1,2,3
	deststring db 4 dup (?)
	b2         db 1,2,3,4,5
EXTRAS ENDS

STACKS SEGMENT
STACKS ENDS

CODES SEGMENT
	       ASSUME CS:CODES,DS:DATAS,SS:STACKS,ES:EXTRAS

           
	START: 
	       MOV    AX,DATAS
	       MOV    DS,AX
	       cld                                         	;DF=0
	       mov    cx,4
	       mov    SI,offset srcstring
	       mov    DI,offset deststring
	       REP    movsb
	       mov    si,0
	OUTPUT:
	       mov    dl,deststring[si]
	       add    si,1
	       mov    ah,2
	       int    21h
	       cmp    si,4
	       jb     OUTPUT





	       MOV    AH,4CH
	       INT    21H
CODES ENDS
    END START
