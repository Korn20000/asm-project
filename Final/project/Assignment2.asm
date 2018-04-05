;
; project.asm
;
; Created: 02/04/2018 16:02:23
; Author : marega and KoRn
;

.equ array_start = 0x200
.equ array_length = 8

LDI R21, LOW(RAMEND)
OUT SPL, R21
LDI R21, HIGH(RAMEND)
OUT SPH, R21
;==============indication on game startup=================;

;; setting of portA and port B
LDI R22, 10
LDI R20, 0x00 ; r20 = 0000 0000
OUT DDRB, R20 ; ddrb mode output (to send info from switch to leds)
LDI R21, 0xFF ; r21 = 1111 1111
OUT DDRA, R21 ; ddra mode input (to know the leds)


startGameBlink:
COM R21 ; complement value in R16
OUT PORTA, R21 ; push the value in R16 to PORTA
//CALL delay
DEC R22 ; each loop we will dec r23 until 0 and then we go out of the loop
BREQ start
RJMP startGameBlink ; loop back and break if R23 is 0


/*
start_stop_game2:
NOP
RJMP start_stop_game2 ;this should break when done with 5 blinks aka. it should start the game
*/


; clear register and add our sequence
CLR R16 
CLR R17 
CLR R18 
CLR R19
CLR R20
CLR R21
CLR R22
CLR R24

;;r23 for checking if user sequence is the same
CLR R23
LDI R23, 0x00

LDI R16, 0b11111101 ; led 1 
LDI R17, 0b11110111 ; led 3
LDI R18, 0b11111101 ; led 1
LDI R19, 0b11011111 ; led 5
LDI R20, 0b11111110	; led 0
LDI R27, 0b01111111	; led 7
LDI R22, 0b11111011	; led 2
LDI R24, 0b11101111	; led 4

;;storage begin / preparation
LDI ZL, low(array_start)
LDI ZH, high(array_start)
CLR R0

LDI R25, array_length

init_array:
ST Z+, R0 ; initialize "array" with zeros
DEC R25 ; using a counter to keep track of the "array"-length
BRNE init_array

LDI ZL, low(array_start)
LDI ZH, high(array_start)
LDI R25, array_length
LDI R26, 0x00

store_in_array:
ST Z+, R16
ST Z+, R17
ST Z+, R18
ST Z+, R19
ST Z+, R20
ST Z+, R27
ST Z+, R22
ST Z+, R21

start:
CALL get_value_with_index
CALL BlinkingSequence
INC R26


;scenario : led qui clignote 
BlinkingSequence:
LDI ZL, low(array_start)
LDI ZH, high(array_start)
;ld r25, Z ; r25 = value of Z and post inc
LDI R27, 0xff
CALL delay
OUT porta, R23
CALL delay
CALL delay
OUT porta, R27
DEC R25
BREQ start_stop_game
RET

; scenario : tout est prêt on va appuyer apres que la led à clignoté maintenant au tour de l'utilisateur de choisir le bouton
	// traduction : everything is ready we will press after the led blink, now it's the turn of the user to choose the button
Again2:
CLR r28		; erase everything
IN R28, PINB	; put the value of the switches in r22
CPI R28, 0xFF	; compare r22 w/ the value 0xff
BRNE next		; if r22 <> 0xff go to next
rjmp Again2		; else jmp to Again2


next:
CP R23, R28		; compare sequence with what the user press
BREQ goodAnswer; ; if r23 = r22 go to good answer
BRNE badAnswer; if r23 <> r22 go to bad answer

;==============indication of good answer=================;

;;Registers for good answer
LDI R29, 0xFF ; start LED
OUT DDRA, R29 ; PORTA is output

LDI R30, 1
LDI R31, 0

goodAnswer:
OUT PORTA, R30
CALL delay
NOP
OUT PORTA, R31
INC R30
BREQ nextLevel
BRNE goodAnswer ; loop back and break if R16 is not 8

CLR R29
CLR R30
CLR R31
;==============indication of bad answer=================;

;;Registers for bad answer
LDI R29, 4 ; we just want 1 long blink
LDI R30, 0xFF
OUT DDRA, R30 ; PORTA is output

badAnswer:
COM R30 ; complement value in R16
OUT PORTA, R30 ; push the value in R16 to PORTA
CALL delay
DEC R29 ; each loop we will dec r23 until 0 and then we go out of the loop
BREQ start
RJMP badAnswer ; loop back and break if R23 is 0

CLR R29
CLR R30
CLR R31

//CALL startGameBlink*/

nextLevel: 
CLR R19
MOV R19, R23 
LDI R23, 0 
CALL backBlink
MOV R23, R19
INC R23
CALL get_value_with_index
// blink the next led (we need to use z+)
// 2nd blinking led 3nd blinking led ..
// stack things.. 
RJMP start

backBlink:
CP R23, R19
CALL BlinkingSequence
INC R23
BRNE backBlink
RET

get_value_with_index:
LDI ZL, low(array_start)
LDI ZH, high(array_start)
ADD ZL, R23 ; we should check for overflows here!
LD R23, Z
RET

start_stop_game:
NOP
RJMP start_stop_game ;this should break when done with 5 blinks aka. it should start the game

delay:  
LDI R16, 50  
loop3: 
LDI R17, 100 
loop2: 
LDI R18, 100
loop1: 
DEC R18  
BRNE loop1 ;keep decreasing R19
DEC R17 
BRNE loop2 ; everytime we decrease R18 then we use previous loop
DEC R16  
BRNE loop3 ; sane as loop2 instead we decrease R17
RET        ; return precious address*/
