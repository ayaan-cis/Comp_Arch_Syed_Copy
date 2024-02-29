%include "asm_io.inc"

segment .data
game_prompt_p1 db "R, P, S, L, $?: ", 0                         ; Prompt for player 1
game_prompt_p2 db "R, P, S, L, $?: ", 0                         ; Prompt for player 2
player_1_win db "Player 1 wins!", 0                             ; Player 1 win message
player_2_win db "Player 2 wins!", 0                             ; Player 2 win message
tie_message db "It's a tie!", 0                                 ; Tie message
invalid_input_prompt db "Invalid input, please try again.", 0   ; Prompt for invalid input

segment .bss
player_1_choice resb 1      ; Reserve 1 byte for player 1's choice
player_2_choice resb 1      ; Reserve 1 byte for player 2's choice

segment .text
    global asm_main    
asm_main:
    enter 0,0
    pusha

    ; After first call to read_char
    mov eax, game_prompt_p1     ; Print the game prompt for player 1
    call print_string           ; Print the game prompt for player 1
    call read_char              ; Read the input
    mov [player_1_choice], eax  ; Store the character in player_1_choice
    call print_nl               ; Print a newline

; Clear input buffer
next_input:
    call read_char            ; Read next character
    cmp eax, 10                ; Check if it's newline
    je go_to_next_input       ; If newline, finish clearing
    jmp next_input        ; Otherwise, keep clearing
go_to_next_input:

; Now proceed with player 2
    mov eax, game_prompt_p2     ; Print the game prompt for player 2
    call print_string           ; Print the game prompt for player 2
    call read_char              ; Read the input
    mov [player_2_choice], eax  ; Store the character in player_2_choice

; Clear input buffer again
second_input:
    call read_char            ; Read next character
    cmp eax, 10                ; Check if it's newline
    je finish_input        ; If newline, finish clearing
    jmp second_input        ; Otherwise, keep clearing
finish_input:

    movzx eax, byte [player_1_choice]   ; Convert player 1's choice to a byte, as it wouldn't work without it
    movzx ebx, byte [player_2_choice]   ; Convert player 2's choice to a byte

    cmp eax, ebx            ; Compare the two choices
    je tie                  ; If they're the same, it's jumps to tie

    cmp eax, 'R'            ; Check if Player 1 chose rock
    je player_1_rock        ; If so, jump to player_1_chose_rock

    cmp eax, 'P'            ; Check if Player 1 chose paper
    je player_1_paper       ; If so, jump to player_1_chose_paper

    cmp eax, 'S'            ; Check if Player 1 chose scissors
    je player_1_scissors    ; If so, jump to player_1_chose_scissors

    cmp eax, 'L'            ; Check if Player 1 chose lizard
    je player_1_lizard  ; If so, jump to player_1_chose_lizard

    cmp eax, '$'            ; Check if Player 1 chose spock
    je player_1_spock  ; If so, jump to player_1_chose_spock

    jmp game_end            ; Otherwise, it jumps to game_end

tie:
    mov eax, tie_message    ; Print the tie message
    call print_nl           ; Print a newline
    call print_string       ; Print the tie message
    jmp game_end            ; Jump to game_end
end_tie:

player_1_rock:
    cmp ebx, 'S'            ; Check if Player 2 chose scissors
    je player_1_wins        ; If so, jump to player_1_wins
    cmp ebx, 'L'            ; Check if Player 2 chose lizard
    je player_1_wins        ; If so, jump to player_1_wins

    cmp ebx, 'P'            ; Check if Player 2 chose paper
    je player_2_wins        ; If so, jump to player_2_wins
    cmp ebx, '$'            ; Check if Player 2 chose Spock
    je player_2_wins        ; If so, jump to player_2_wins

    jmp game_end            ; Otherwise, it jumps to game_end
end_player_1_rock:

player_1_paper:
    cmp ebx, 'R'            ; Check if Player 2 chose rock
    je player_1_wins        ; If so, jump to player_1_wins
    cmp ebx, '$'            ; Check if Player 2 chose Spock
    je player_1_wins        ; If so, jump to player_1_wins

    cmp ebx, 'S'            ; Check if Player 2 chose scissors
    je player_2_wins        ; If so, jump to player_2_wins
    cmp ebx, 'L'            ; Check if Player 2 chose lizard
    je player_2_wins        ; If so, jump to player_2_wins

    jmp game_end            ; Otherwise, it jumps to game_end
end_player_1_paper:

player_1_scissors:
    cmp ebx, 'P'            ; Check if Player 2 chose paper
    je player_1_wins        ; If so, jump to player_1_wins
    cmp ebx, 'L'            ; Check if Player 2 chose lizard
    je player_1_wins        ; If so, jump to player_1_wins

    cmp ebx, 'R'            ; Check if Player 2 chose rock
    je player_2_wins        ; If so, jump to player_2_wins
    cmp ebx, '$'            ; Check if Player 2 chose Spock
    je player_2_wins        ; If so, jump to player_2_wins

    jmp game_end            ; Otherwise, it jumps to game_end
end_player_1_scissors:

player_1_lizard:
    cmp ebx, '$'            ; Check if Player 2 chose Spock
    je player_1_wins        ; If so, jump to player_1_wins
    cmp ebx, 'P'            ; Check if Player 2 chose paper
    je player_1_wins        ; If so, jump to player_1_wins

    cmp ebx, 'R'            ; Check if Player 2 chose rock
    je player_2_wins        ; If so, jump to player_2_wins
    cmp ebx, 'S'            ; Check if Player 2 chose scissors
    je player_2_wins        ; If so, jump to player_2_wins

    jmp game_end            ; Otherwise, it jumps to game_end
end_player_1_lizard:

player_1_spock:
    cmp ebx, 'S'            ; Check if Player 2 chose scissors
    je player_1_wins        ; If so, jump to player_1_wins
    cmp ebx, 'R'            ; Check if Player 2 chose rock
    je player_1_wins        ; If so, jump to player_1_wins

    cmp ebx, 'L'            ; Check if Player 2 chose lizard
    je player_2_wins        ; If so, jump to player_2_wins
    cmp ebx, 'P'            ; Check if Player 2 chose paper
    je player_2_wins        ; If so, jump to player_2_wins

    jmp game_end            ; Otherwise, it jumps to game_end
end_player_1_spock:

player_1_wins:
    mov eax, player_1_win   ; Print the player 1 win message
    call print_nl           ; Print a newline
    call print_string       ; Print the player 1 win message
    jmp game_end            ; Jump to game_end
end_player_1_wins:

player_2_wins:
    mov eax, player_2_win   ; Print the player 2 win message
    call print_nl           ; Print a newline
    call print_string       ; Print the player 2 win message
    jmp game_end            ; Jump to game_end
end_player_2_wins:

game_end:            ; This is where the game ends
    popa            
    leave
    ret
finish_game_end:   


    popa
    leave
    ret