; Base Author: Megan Avery Spring 2024
; Exercise Author: Ayaan Syed
;
; Purpose - to learn about loops in NASM

%include "asm_io.inc"
segment .data						; initialized data
rocket db "Takeoff!", 0

perfect_prompt db "Enter a power: ", 0
perfect db "Perfect!", 0
another_perfect_prompt db "Run it back Turbo: ", 0

fear_the_goat db "Fear the GOAT!", 0
response_prompt db "Response? ", 0

abc db "ABC", 0

segment .bss						; uninitialized data


segment .text						; code
        global  asm_main
asm_main:
        enter   0,0               	; setup routine
        pusha

	; TODO: FOR EXERCISE
;         mov ecx, 5
; for: 
;         mov eax, ecx
;         call print_int
;         call print_nl
;         loop for
; endfor:
;         mov eax, rocket
;         call print_string
;         call print_nl

	; TODO: WHILE EXERCISE
;         mov eax, perfect_prompt
;         call print_string
;         call read_int
; while:
;         mov ebx, eax
;         dec ebx
;         and eax, ebx
;         cmp eax, 0
;         jne endwhile

;         mov eax, perfect
;         call print_string
;         call print_nl

;         mov eax, another_perfect_prompt
;         call print_string
;         call read_int

;         jmp while

; endwhile:

	; TODO: DO WHILE EXERCISE
; do:
;         mov eax, fear_the_goat
;         call print_string
;         call print_nl

;         mov eax, response_prompt
;         call print_string
;         call read_int

;         cmp eax, "!"
        
;         jne do

        mov eax, abc
        call print_string
        call print_nl

        mov ecx, 1     ; Set ecx to 1 initially
for: 
        mov eax, ecx   ; Move the current value of ecx to eax
        call print_int ; Print the number
        call print_nl  ; Print a newline
        inc ecx        ; Increment ecx
        cmp ecx, 4     ; Compare ecx with 6
        jne for        ; Jump to 'for' if ecx is not equal to 6
endloop:


        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
