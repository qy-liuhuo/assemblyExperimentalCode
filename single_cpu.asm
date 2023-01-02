data segment
data ends
code segment
	      assume cs:code,ds:data
	start:
	      mov    ax,data
	      mov    ds,ax

	;结束
	      mov    ah,4ch
	      int    21h
code ends

end start
