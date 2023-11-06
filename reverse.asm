;this is a commented version so that we remember what we are doing
;Sandra Deutl and Katheryne Lochart

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

checkWord:
    cmp rax, 8 ;this is the size
    jl  promptWord

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

print:
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
