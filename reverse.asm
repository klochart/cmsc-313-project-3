;this is a commented version so that we remember what we are doing
;Sandra Deutl and Katheryne Lochart
; remember to check formatting before submitting

section .data

wordPrompt:     db "Please enter the text: ", 0
wordPromptLen:  equ $- wordPrompt

numPrompt:      db "Enter a number between 2 and the total number of characters in the string ", 0
numPromptLen:   equ $- numPrompt

resultStr:      db "Unedited String: ", 0
resultStrLen:   equ $- resultStr

calcStr:        db "Edited String: ", 0
calcStrLen:     equ $- calcStr

newLine:        db 10

section .bss

string:         resb 100
strLen:         resb 3
num:            resb 3

section .text

global main

main:
    xor r8b, r8b
    xor r9b, r9b

promptWord:
    mov rax, 1
    mov rdi, 1
    mov rsi, wordPrompt 
    mov rdx, wordPromptLen
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, string
    mov rdx, 64
    syscall

;something weird below
checkWord:
    dec rax ;for new line key
    cmp rax, 8 ;this is the size
    jl  promptWord
    mov r12, rax ;can you move this into something?

promptNum:
    mov rax, 1
    mov rdi, 1
    mov rsi, numPrompt 
    mov rdx, numPromptLen
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, num
    mov rdx, 2
    syscall

; be careful of memory allocated, mov to r8 and 10 to al or vice versa
; not enough memory allocated, 
; be mindful of what number you read first and if there should be a check for the next number
checkNum:
    dec rax
    cmp rax, 1
    jg convertNumDouble
    jmp convertNumSingle

convertNumDouble:
    mov r8b, byte[rax] ;moving to empty register
    sub r8b, 48
    mov al, 10
    mul r8b
    add r9b, r8b ;r9 stores temp number
    inc rax ;moving to next digit

convertNumSingle:
    mov r8b, byte[rax]
    sub r8b, 48
    add r9b, r8b
    cmp r9b, 2
    jl promptNum
    cmp r9b, r12b ;can you do this?
    jg promptNum

printUnedited:
    mov rax, 1
    mov rdi, 1
    mov rsi, resultStr
    mov rdx, resultStrLen
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, string
    mov rdx, 64
    syscall

printEdited:

    mov rax, 1
    mov rdi, 1
    mov rsi, newLine
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, calcStr 
    mov rdx, calcStrLen
    syscall

exit:
    mov rax, 60
    xor rdi, rdi
