;简单I/O口扩展

; 连线：
; 输入输出 INL ----- 端口地址 300IN
; 输入输出 i0~i7 --- 逻辑电平开关 K0~K7
; 输入输出 OUTL ---- 端口地址 300OUT
; 输入输出 o0~o7 --- 发光二极管 L0~L7
; 输入输出 D0~D7 --- 数据总线 D0~D7

CS_IO   EQU 0300H

CODE SEGMENT
	      ASSUME CS:CODE
START PROC NEAR

	again:mov    dx,300H
	      in     al,dx
	      cmp    al,11111111B
	      jnz    L1
	      out    dx,al
	      jmp    again

	L1:   
	      mov    cx,8
	      mov    al,11111110B
	L2:   
	      out    dx,al
	      call   delay
	      rol    al,1
	      loop   L2
        
	      jmp    again

delay proc

	      push   cx


	      mov    cx,50000
	L5:   
	      dec    cx
	      cmp    cx,0
	      jne    L5


	      pop    cx

	      ret
delay endp

        
START ENDP


CODE    ENDS
        END START