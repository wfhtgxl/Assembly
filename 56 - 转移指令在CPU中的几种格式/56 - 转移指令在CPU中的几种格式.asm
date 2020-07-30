; 56 - 转移指令在CPU中的几种格式
; =================================================================



assume cs:codesg

codesg segment
	s:	mov ax, 0
		mov bx, 0
		JMP s1		; 格式1：直接 【JMP  标号】 EB??

		nop

	s1:	mov ax, 1
		mov bx, 1
		JMP short s2	; 格式2：【JMP short 标号】 --> 适用范围：[-127, 127] 8位位移

		nop

	s2:	mov ax, 2
		mov bx, 2
		JMP near ptr s3	; 格式3：【JMP near ptr 标号】 --> 适用范围：[-32768, 32768] 16位位移

		nop

	s3:	db 0FEH dup ('+')
		JMP far ptr s4	; 格式4：【JMP far ptr 标号】 --> 会将CS指向s4的CS，IP指向s4的IP

		nop ; 占用1字节

	s4:	db 0FEH dup ('-')

		nop
codesg ends

end s


; =================================================================
; 如果在Debug中调试运行，会发现机器指令并不是预想的那样。至于为什么这样请查阅书中的附录3
; 简单说明：
;	如果机器指令跳转的没有那么远，编译器会按照较短的机器指令来处理
;	比如：JMP NEAR PTR S3, JMP FAR PTR 会被翻译成 EB?? --> 可见，跳转部分只占用了1个字节
; =================================================================
