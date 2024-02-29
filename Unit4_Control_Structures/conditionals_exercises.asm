; Base Author: Megan Avery Spring 2024
; Exercise Author: Ayaan Syed
;
; Purpose - to learn about conditionals in NASM

%include "asm_io.inc"


segment .data					; initialized data
if_prompt db "Enter a character: ", 0
if_output db "huh?", 0

number_prompt db "Enter a number: ", 0
even db "EVEN", 0
odd db "ODD", 0

segment .bss					; uninitialized data


segment .text					; code
        global  asm_main
asm_main:
        enter   0,0            	; setup routine
        pusha

	; TODO: IF EXERCISE
        ; mov eax, if_prompt
        ; call print_string
        ; call read_char
;
;         cmp eax, '&'
;         jne endif
;         mov eax, if_output
;         call print_string
; endif:
;         call read_char

	; TODO: IF/ELSE EXERCISE
        mov eax, number_prompt
        call print_string
        call read_int
        
        and eax, 1
        
        cmp eax, 0
        je even_block
        mov eax, odd
        call print_string
        jmp end_ifelse

even_block:
        mov eax, even
end_ifelse:
        call print_string

	; TODO: ELIF EXERCISE


	; TODO: AND EXERCISE

        popa
        mov     eax, 0        	; return back to C
        leave                     
        ret
