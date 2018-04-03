;
; AssemblerApplication7.asm
;
; Created: 03/04/2018 10:09:29
; Author : marega
;


;indication on game startup
LDI R16, LOW(RAMEND)
OUT SPL, R16
LDI R16, HIGH(RAMEND)
OUT SPH, R16

main:  
LDI R23, 5 ; we just want 5 blinking
LDI R16, 0xFF  
OUT DDRA, R16 ; PORTA is output

back: 

COM R16 ; complement value in R16  
OUT PORTA, R16 ; push the value in R16 to PORTB  
CALL delay  
dec R23 ; each loop we will dec r23 until 0 and then we go out of the loop
; cpi r23, 0x00 ; compare r23 to 0		//useless
breq nextThings ; if r23 = 0 go to nextThings else
RJMP back ; infinite loop (should be changed later to a couple of times, and then game start)


delay:  
	LDI R17, 50  
	loop3: LDI R18, 255  
	loop2: LDI R19, 255  
	loop1: DEC R19  
	BRNE loop1 ;keep decreasing R19
	DEC R18  
	BRNE loop2 ; everytime we decrease R18 then we use previous loop
	DEC R17  
	BRNE loop3 ; sane as loop2 instead we decrease R17
	RET        ; return precious address

nextThings:
	nop;

