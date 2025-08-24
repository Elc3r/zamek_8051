;	R2 - klavesnice
;	R3 - sekundy
;	R4 - minuty
;	R6, R7 - zpozdeni

	org 0

	mov R3, #0
	mov R4, #0

start:
	call displej
	call zpozdeni
	call klavesnice

; inkrementace minut
	cjne R2, #1, d1
	inc R4
	cjne R4, #60, d1
	mov R4, #0
; inkrementace sekund
d1:
	cjne R2, #3, d2
	inc R3
	cjne R3, #60, d2
	mov R3, #0
; dekrementace minut
d2:
	cjne R2, #4, d3
	dec R4
	cjne R4, #255, d3
	mov R4, #59
; dekrementace sekund
d3:
	cjne R2, #6, d4
	dec R3
	cjne R3, #255, d4
	mov R3, #59
d4:
	cjne R2, #2, spusteno
	mov R5, #1
spusteno:
	cjne R5, #1, start1
odpocet:
	dec R3
	cjne R3, #255, start1
	mov R3, #59
	dec R4
	cjne R4, #255, start1
	mov R3, #0
	mov R4, #0
	mov R5, #0
start1:
	jmp start

klavesnice:
	mov A, P1
	orl A, #11110000b
	cpl A
	mov R2, A
	ret

displej:
	mov A, R3
	mov B, #10
	div AB
	orl A, #00010000b
	mov P3, A

	mov A, B
	orl A, #00000000b
	mov P3, A

	mov A, R4
	mov B, #10
	div AB
	orl A, #00110000b
	mov P3, A

	mov A, B
	orl A, #00100000b
	mov P3, A

	ret

zpozdeni:
	djnz R7, zpozdeni
	djnz R6, zpozdeni
	ret
end