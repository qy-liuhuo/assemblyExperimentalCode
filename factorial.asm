data segment
	;定义一个一字节的变量
	temp db 0
data ends
code segment
	      assume cs:code,ds:data
	start:
	      mov    ax,data
	      mov    ds,ax
	;输入
	      mov    ah,1
	      int    21h
	      sub    al,48          	;转数字
	      mov    ax,1           	;ax先赋初值1
	      mov    cl,al
	L0:   cmp    cl,0
	      je     L1
	      mul    cl
	      sub    cl,1
	      jmp    L0
	L1:   
	;输出
	      mov    dl,al
	      mov    ah,2
	      int    21h
	;结束
	      mov    ah,4ch
	      int    21h

          

	
code ends

end start
