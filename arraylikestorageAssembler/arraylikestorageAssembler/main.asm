;
; arraylikestorageAssembler.asm
;
; Created: 03/04/2018 19:45:58
; Author : marega
;


.equ array_start = 0x200
.equ array_length = 5
; int[] array = new int[5];
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
st Z+, r16 ; storing the value of the counter in the array
dec r16
brne store_in_array
ldi r16, 3 ; the index of the value we would like to get
call get_value_with_index ; result will be saved in r16

end:
rjmp end

get_value_with_index:
ldi ZL, low(array_start)
ldi ZH, high(array_start)
add ZL, r16 ; we should check for overflows here!
ld r16, Z
ret
