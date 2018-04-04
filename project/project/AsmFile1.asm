;
; project.asm
;
; Created: 02/04/2018 16:02:23
; Author : marega
;

// this is just thing to blink a led when you press a button
				// port B = switches / port A = leds

.equ array_start = 0x200
.equ array_length = 8

	; setting of portA and port B
LDI r20, 0x00 ; r20 = 0000 0000
out ddrb, r20 ; ddrb mode output (to send info from switch to leds)
ldi r21, 0xff ; r21 = 1111 1111
out ddra, r21 ; ddra mode input (to know the leds)

;r26 for checking if user sequence it's the same
clr r26
ldi r26, 0x00

; clear register and add our sequence
clr r13
clr r14
clr r15
clr r17
clr r18
clr r19
clr r20
clr r24

ldi r13, 0b11111101 ; led 1 
ldi r14, 0b11110111 ; led 3
ldi r15, 0b11111101 ; led 1
ldi r17, 0b11011111 ; led 5
ldi r18, 0b11111110	; led 0
ldi r19, 0b01111111	; led 7
ldi r20, 0b11111011	; led 2
ldi r24, 0b11101111	; led 4



;storage begin / preparation
	ldi ZL, low(array_start)
	ldi ZH, high(array_start)
	clr r0

	ldi r16, array_length
init_array:
	st Z+, r0 ; initialize "array" with zeros
	dec r16 ; using a counter to keep track of the "array"-length
	brne init_array


	ldi ZL, low(array_start)
	ldi ZH, high(array_start)
	ldi r16, array_length

store_in_array:
st Z+, r13
st Z+, r14
st Z+, r15
st Z+, r17
st Z+, r18
st Z+, r19
st Z+, r20
st Z+, r21


;end:
;	rjmp end

; r26 for getting value

get_value_with_index:
	ldi ZL, low(array_start)
	ldi ZH, high(array_start)
	;add ZL, r26 ; we should check for overflows here!
	;ld r26, Z
	ret
 

/*
Again: 
	in r19, pinb
	out porta, r19
	jmp Again
	*/

	; scenario : tout est prêt on va appuyer apres que la led à clignoté maintenant au tour de l'utilisateur de choisir le bouton
	// traduction : everything is ready we will press after the led blink, now it's the turn of the user to choose the button
Again2:
clr r22		; erase everything
in r22, pinb	; put the value of the switches in r22
cpi r22, 0xff	; compare r22 w/ the value 0xff
brne next		; if r22 <> 0xff go to next
jmp Again2		; else jmp to Again2


next:
	cp r13, r22		;
	breq goodAnswer;
	brne badAnswer;


goodAnswer:
	; blinking things
	// ...
	jmp nextLevel 


badAnswer:
	; blinking things
	// ...

nextLevel: 
	// 2 blinking led 3 blinking led ..
	// stack things.. 
	
	
	/*
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
CALL DELAY  
dec R23 ; each loop we will dec r23 until 0 and then we go out of the loop
; cpi r23, 0x00 ; compare r23 to 0		//useless
breq nextThings ; if r23 = 0 go to nextThings else
RJMP back ; infinite loop (should be changed later to a couple of times, and then game start)

 nextThings:
	nop;

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
*/

/*
;switches
Light_all:
LDI R16, 0x00
COM R16
OUT DDRB, R16
LDI R17, 0xFF
OUT DDRA, R17

again:
IN R18, PINB
OUT PORTA,R18
JMP again
*/
