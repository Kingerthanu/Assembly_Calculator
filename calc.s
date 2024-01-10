# CPSC 2500 Winter 2023
# Name: Benjamin R Spitzauer
# Date: 5/1/2023 

# Compile on Linux using: gcc -g -fno-pie -no-pie ./calc.s -o calc

.bss # block starting symbol, contains allocated but not yet initialized memory
num: # num will hold a 64 bit integer provided by the user
    .skip 8

.data
addstr: # C-style formatting for calling printf()
    .asciz "%d + %d -> %d\n"

.text
.global main

getint: # get integer from user
    movq $0, %rax
    movq $0, %rdi
    movq $num, %rsi
    movq $8, %rdx
    syscall # get user input from STDIN

    movq $num, %rdi
    call atoi # convert user input from string to integer
    ret

printint: # print result of addition
    mov $addstr, %rdi
    mov %r14, %rsi
    mov %rax, %rdx
    mov %r15, %rcx
    xor %rax, %rax
    call printf
    ret

end: # terminate program
    mov $60, %rax
    xor %rdi, %rdi
    syscall

main:
    call getint
    mov %rax, %r15
    call getint
    mov %r15, %r14
    add %rax, %r15

    call printint    
   
    call end
