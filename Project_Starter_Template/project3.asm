%include "asm_io.inc"

segment .data
    inputNum  db "Enter your favorite number: ", 0     ; Prompt message
    product10  db "Number * 10: ", 0       ; Result message after * 10
    product72  db "Number * 72: ", 0       ; Result message after * 72
    product81  db "Number * 81: ", 0       ; Result message after * 81
    starter db "Starting number: ", 0       ; Starting number message

segment .bss
    number resd 1    ; Space for the input number
    result10 resd 1     ; Space for the result of 10
    result72 resd 1     ; Space for the result of 72
    result81 resd 1     ; Space for the result of 81
    middleground resd 1    ; Space for the intermediate result, used for the 81 multiplication

segment .text
    global asm_main  ; declare the entry point of the program
    
asm_main:
    enter 0,0       ; setup stack frame
    pusha        ; save registers

    mov eax, inputNum       ; Load the prompt message
    call print_string       ; Print the prompt message
    call read_int       ; Read the input number
    mov [number], eax       ; Store the input number

    ; Print the "Starting number: " message
    mov eax, starter     ; Load the address of the 'starter' message
    call print_string    ; Print the 'starter' message

    ; Print the actual starting number
    mov eax, [number]    ; Load the starting number
    call print_int       ; Print the input number
    call print_nl        ; Add a new line for better readability

    mov eax, [number]      ; Load the input 
    mov ebx, eax           ; Copy it to ebx for multiplication
    add eax, eax           ; 2 * the input
    add eax, eax           ; 4 * the input
    add eax, eax           ; 8 * the input
    add ebx, ebx           ; 2 * the input
    add eax, ebx           ; 10 * input, achieved by adding 8 * input and 2 * input

    mov [result10], eax      ; Store the result

    dump_regs 1     ; Dump register

    mov eax, product10        ; Load the result 
    call print_string       ; Print the result 
    mov eax, [result10]    ; Load the result
    call print_int      ; Print the result
    call print_nl  ; Added a line for better readability

    mov eax, [number]  ; Load the input 
    mov ebx, eax       ; Copy it to ebx for later use
    add eax, eax       ; 2 * the input
    add eax, eax       ; 4 * the input
    add eax, eax       ; 8 * the input
    add eax, eax       ; 16 * the input
    add eax, eax       ; 32 * the input
    add eax, eax       ; 64 * the input

    add ebx, ebx       ; 2 * the input
    add ebx, ebx       ; 4 * the input
    add ebx, ebx       ; 8 * the input

    add eax, ebx        ; 72, which is done by adding 64 * the input & 8 * the input

    mov [result72], eax     ; Store the result

    dump_regs 2     ; Dump register

    mov eax, product72        ; Load the result 
    call print_string       ; Print the result 
    mov eax, [result72]    ; Load the result
    call print_int
    call print_nl  ; Added line for better readability

    mov eax, [number]   ; Load the input

    mov ebx, eax       ; Copy it to ebx for multiplication
    add ebx, ebx       ; 2 * the input
    add ebx, ebx       ; 4 * the input
    add ebx, ebx       ; 8 * the input
    add ebx, eax       ; 9, achieved by adding the original number

    mov [middleground], ebx     ; Store the intermediate result

    mov eax, [middleground] ; Get the intermediate result
    mov ecx, eax            ; Copy it to ecx for multiplication
    add ecx, ecx            ; 2 * the intermediate
    add ecx, ecx            ; 4 * the intermediate
    add ecx, ecx            ; 8 * the intermediate
    add ecx, eax            ; 9 * the intermediate, done by adding the original intermediate result

    mov [result81], ecx     ; Store the result

    dump_regs 3     ; Dump register

    mov eax, product81        ; Load the result
    call print_string       ; Print the result
    mov eax, [result81]     ; Load the result
    call print_int      ; Print the result
    call print_nl  ; Add a new line for better readability


    popa
    leave
    ret
