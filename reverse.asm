;this is a commented version so that we remember what we are doing
;Sandra Deutl and Katheryne Lochart

section .data

;get input from user
wordPrompt:     db "Please enter the text: ", 0
wordPromptLen:  equ $- wordPrompt

numPrompt:      db "Enter a number between 2 and the total number of characters in the string ", 0
numPromptLen:   equ $- numPrompt

newLine:        db 10

section .bss

string:         resb 64
num:            resb 2

section .text

global main

main:
    ;store user given string
    mov rax, 1
    mov rdi, 1
    mov rsi, wordPrompt 
    mov rdx, wordPromptLen
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, string
    mov rdx, 256
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, numPrompt 
    mov rdx, numPromptLen
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, num
    mov rdx, 256
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, string
    mov rdx, 64
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, num
    mov rdx, 2
    syscall



exit:
    mov rax, 60
    xor rdi, rdi