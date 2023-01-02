data segment
	;定义一个一字节的变量
	temp db 0
data ends
code segment
	      assume cs:code,ds:data
	start:
	      mov    ax,data
	      mov    ds,ax
	;第一次
	      mov    ah,1
	      int    21h
	      sub    al,48
	;输出个位
	      pop    dx
	      mov    dl,dh
	      add    dl,48
	      mov    ah,2
	      int    21h
	;结束
	      mov    ah,4ch
	      int    21h

          

	
code ends

end start
