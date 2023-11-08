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
    xor r8, r8

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
convertNum:
    mov r8b, [num] ;moving to empty register
    sub r8, 48 
    imul r8, 10
    add r9, r8 ;r9 stores temp number
    inc rsi ;moving to next digit
    mov r8, [num]
    sub r8, 48
    add r9, r8
    cmp r9, 2
    jl promptNum
    cmp r9, r12 ;can you do this?
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
