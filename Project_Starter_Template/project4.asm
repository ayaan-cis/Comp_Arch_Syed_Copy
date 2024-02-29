%include "asm_io.inc"

segment .data
    signs db "+-", 0
    prompt_enter_number db "Enter a number in two's complement: ", 0    ; Prompt for the input number
    prompt_enter_shift db "Number to shift left by: ", 0    ; Prompt for the shift amount
    prompt_signed_magnitude db "In signed magnitude: ", 0   ; Prompt for the signed magnitude
    prompt_carry db "Carry: ", 0    ; Prompt for the carry flag
    format_string db "%d", 0    ; Format string for printing integers

segment .bss
    num resd 1  ; Reserve space for the input number
    shift_amount resb 1 ; Reserve space for the shift amount
    carry_flag resb 1   ; To store the carry flag after shifting


segment .text
    global asm_main ; declare the entry point of the program

    
asm_main:
    enter 0,0   ; setup stack frame
    pusha   ; save registers

    mov eax, prompt_enter_number    ; Print the prompt
    call print_string   ; Print the prompt
    call read_int   ; Read the input number
    mov [num], eax  ; Store the input number

    ; Convert to 8-bit signed magnitude and print
    mov eax, prompt_signed_magnitude    ; Print the prompt
    call print_string
    mov eax, [num]  ; Load the input number
    mov edx, eax    ; Copy input number to edx
    shr edx, 31     ; Isolate the sign bit by shifting it to the least significant bit position
    and eax, 0x7F   ; Get the magnitude by masking out the potential sign bit
    push eax    ; Save magnitude for printing
    mov eax, edx    ; Load the sign status into eax
    add eax, signs      ; Adjust pointer based on sign
    movzx eax, byte [eax]   ; Load the sign character
    call print_char     ; Print the sign
    pop eax     ; Restore magnitude
    call print_int      ; Print the magnitude
    call print_nl       ; New line

    mov eax, prompt_enter_shift   ; Print the prompt    
    call print_string       ; Print the prompt
    call read_int       ; Read the shift amount
    mov [shift_amount], al      ; Store the shift amount

    mov cl, [shift_amount]  ; Load the shift amount
    mov eax, [num]    ; Load the input number   
    shl eax, cl          ; Shift left
    setc [carry_flag]    ; Set carry_flag based on the carry out of the last bit shifted
    mov [num], eax       ; Store the result back

    mov eax, prompt_carry         ; Print the prompt
    call print_string         ; Print the prompt
    movzx eax, byte [carry_flag] ; Make sure to zero-extend the byte to dword
    call print_int
    call print_nl

    mov eax, prompt_signed_magnitude  ; Print the prompt
    call print_string          ; Print the prompt
    mov eax, [num]      ; Load the result
    and eax, 0xFF   ; Mask to the lower 8 bits to simulate truncation
    mov edx, eax    ; Copy result to edx
    shr edx, 31     ; Isolate the sign bit
    and eax, 0x7F   ; Get the magnitude
    push eax    ; Save magnitude for printing
    mov eax, edx    ; Load the sign status into eax
    add eax, signs          ; Adjust pointer based on sign
    movzx eax, byte [eax]      ; Load the sign character
    call print_char      ; Print the sign
    pop eax              ; Restore magnitude
    call print_int       ; Print the magnitude
    call print_nl        ; New line


    popa
    leave
    ret