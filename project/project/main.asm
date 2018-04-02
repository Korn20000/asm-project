;
; project.asm
;
; Created: 02/04/2018 16:02:23
; Author : marega
;

	// this is just thing to blink a led when you press a button
				// port B = switches / port A = leds
LDI r20, 0x00 ; r20 = 0000 0000
out ddrb, r20 ; ddrb mode output (to send info from switch to leds)
ldi r21, 0xff ; r21 = 1111 1111
out ddra, r21 ; ddra mode input (to know the leds)
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
cpi r22, 0x00	; compare r22 w/ the value 0
brne next		; if r22 <> 0 go to next
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
