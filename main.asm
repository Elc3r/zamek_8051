;	R0 - pozice 1
;	R1 - pozice 2
;	R2 - pozice 3
;	R3 - pozice 4
;	R5 - klavesnice
;	R6, R7 - zpozdeni

	org 0
;	hodnota na displeji
	mov R0, #0
	mov R1, #0
	mov R2, #0
	mov R3, #0
;	pin v paměti
	mov 0x70, #1
	mov 0x71, #2
	mov 0x72, #3
	mov 0x73, #4

start:
	call displej
	call zpozdeni
	call klavesnice

; inkrementace 1
	cjne R5, #1, d1
	inc R0
	cjne R0, #10, d1
	mov R0, #0
; inkrementace 2
d1:
	cjne R5, #2, d2
	inc R1
	cjne R1, #10, d2
	mov R1, #0
; inkrementace 3
d2:
	cjne R5, #3, d3
	inc R2
	cjne R2, #10, d3
	mov R2, #0
; inkrementace 4
d3:
	cjne R5, #4, d4
	inc R3
	cjne R3, #10, d4
	mov R3, #0
; kontorla pinu
d4:
	cjne R5, #6, d5
	mov A, R0
	cjne A, 0x70, d5
	mov A, R1
	cjne A, 0x71, d5
	mov A, R2
	cjne A, 0x72, d5
	mov A, R3
	cjne A, 0x73, d5
b1:
	call blik
	call klavesnice
	cjne R5, #0, znovu
	jmp b1
d5:
	jmp start

znovu:
	mov R0, #0
    	mov R1, #0
    	mov R2, #0
    	mov R3, #0
    	jmp start

klavesnice:
	mov A, P1
	orl A, #11110000b
	cpl A
	mov R5, A
	ret

blik:
	call zhasni
	call zpozdeni
	call displej
	call zpozdeni
	ret

zhasni:
	mov P3, #00001111b
	mov P3, #00011111b
	mov P3, #00101111b
	mov P3, #00111111b
	ret

displej:
	mov A, R0
	orl A, #00110000b
	mov P3, A

	mov A, R1
	orl A, #00100000b
	mov P3, A

	mov A, R2
	orl A, #00010000b
	mov P3, A

	mov A, R3
	orl A, #00000000b
	mov P3, A

	ret

zpozdeni:
	djnz R7, zpozdeni
	djnz R6, zpozdeni
	ret
end