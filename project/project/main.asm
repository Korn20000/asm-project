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
