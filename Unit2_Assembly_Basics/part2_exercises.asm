; Base Author: Megan Avery Spring 2024
; Exercise Author: Ayaan Syed
; 
; Purpose - to learn about the following:
;	-  directives (dx, resx, & times)
;	- printing ints and characters
;	- dumping memory
;	- printing strings
;	- reading chars and ints

%include "asm_io.inc"

age equ 30 ; symbol
%define fav_number 14 ; macro

; initialized data
segment .data
fav_color db "purple", 0 ; string
least_fav_color db "yellow", 0 ; string
number dd 116 ; integer
letter db "A" ; character
name_value dd 65 
name_letter db 
greeting db "Hello World!", 0
char_prompt db "Enter a character: ", 0
int_prompt db "Enter an integer: ", 0
multiple times 5 db "Z" ; 5 bytes of 0

; uninitialized data
segment .bss
space_for_int resd 1 ; integer

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	; mov eax, [number] ; eax = 116
        ; mov dword [number], 32

        ; mov eax, [number] ; eax = 32
        ; call print_int
        ; call print_char

        ; mov eax, [name_value]
        ; call print_int
        ; call print_nl
        ; call print_char

        ; dump_mem 1, fav_color, 0

        ; mov eax, fav_color + 3
        ; call print_string 

        ; mov eax, greeting
        ; call print_string
        ; call print_nl
        ; demp_mem 1, greeting, 0

        ; mov eax, char_prompt
        ; call print_string
        ; call read_char

        ; mov eax, int_prompt
        ; call print_string
        ; call read_int

        dump_mem 1, multiple, 0
        call print_nl
        dump_mem 1, multiple + 3, 0

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


