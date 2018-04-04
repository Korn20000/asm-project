;
; AssemblerApplication7.asm
;
; Created: 03/04/2018 10:09:29
; Author : KoRn
;

;==============indication on game startup=================;
LDI R16, LOW(RAMEND)
OUT SPL, R16
LDI R16, HIGH(RAMEND)
OUT SPH, R16
/*
main:
LDI R23, 10 ; we just want 5 blinking, note that it basically complement it 10 times, to make this more suitable it could be changed to turn on and off LED's 5 times
LDI R16, 0xFF  
OUT DDRA, R16 ; PORTA is output

;;repeat blink 5 times
startGameBlink:
COM R16 ; complement value in R16
OUT PORTA, R16 ; push the value in R16 to PORTA
CALL delay
DEC R23 ; each loop we will dec r23 until 0 and then we go out of the loop
BREQ startGame
RJMP startGameBlink ; loop back and break if R23 is 0*/




;==============indication on game win=================;
LDI R16, 0xFF ; start LED
OUT DDRA, R16 ; PORTA is output

LDI R20, 1
LDI R21, 0
;;increment LED upto 8
gameWin:
OUT PORTA, R20
CALL delay
NOP

OUT PORTA, R21
INC R20

BREQ startGame
BRNE gameWin ; loop back and break if R16 is not 8

/*
;==============indication on game lose=================;
;;basically it is the same as start game just with a long delay and blink once

main:
LDI R23, 1 ; we just want 1 long blink
LDI R16, 0xFF  
OUT DDRA, R16 ; PORTA is output

;;repeat blink 1 times
startGameBlink:
COM R16 ; complement value in R16
OUT PORTA, R16 ; push the value in R16 to PORTA
CALL delay
DEC R23 ; each loop we will dec r23 until 0 and then we go out of the loop
BREQ startGame
RJMP startGameBlink ; loop back and break if R23 is 0*/


startGame:
NOP
RJMP startGame ;this should break when done with 5 blinks aka. it should start the game

delay:  
LDI R17, 10  
loop3: 
LDI R18, 50  
loop2: 
LDI R19, 100  
loop1: 
DEC R19  
BRNE loop1 ;keep decreasing R19
DEC R18  
BRNE loop2 ; everytime we decrease R18 then we use previous loop
DEC R17  
BRNE loop3 ; sane as loop2 instead we decrease R17
RET        ; return precious address