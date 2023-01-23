section .data
    prompt db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    option db "Enter operation (1: add, 2: subtract, 3: multiply, 4: divide): ", 0
    result db "Result: ", 0
    error db "Invalid option", 0

section .bss
    num1 resd 4
    num2 resd 4
    op resb 4

section .text
    global _start

_start:
    mov num1, 0
    mov num2, 0
    mov op, 0
    ; Get first number
    mov eax, 4 ; system call for write
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, prompt
    mov edx, 21 ; length of prompt
    int 0x80 ; call kernel

    ; Read first number
    mov eax, 3 ; system call for read
    mov ebx, 0 ; file descriptor for stdin
    mov ecx, num1
    mov edx, 8 ; length of number
    int 0x80 ; call kernel

    ; Get second number
    mov eax, 4 ; system call for write
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, prompt2
    mov edx, 22 ; length of prompt2
    int 0x80 ; call kernel

    ; Read second number
    mov eax, 3 ; system call for read
    mov ebx, 0 ; file descriptor for stdin
    mov ecx, num2
    mov edx, 8 ; length of number
    int 0x80 ; call kernel

    ; Get operation
    mov eax, 4 ; system call for write
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, option
    mov edx, 56 ; length of option
    int 0x80 ; call kernel

    ; Read operation
    mov eax, 3 ; system call for read
    mov ebx, 0 ; file descriptor for stdin
    mov ecx, op
    mov edx, 1 ; length of operation
    int 0x80 ; call kernel

    ; Perform operation
    fld dword [num1]
    fld dword [num2]

    cmp byte [op], '1'
    je add

    cmp byte [op], '2'
    je sub

    cmp byte [op], '3'
    je mul

    cmp byte [op], '4'
    je div

    jmp error_msg

add:
    faddp
    jmp print_result

sub:
    fsubp
    jmp print_result

mul:
    fmulp
    jmp print_result

div:
    fdivp
    jmp print_result

error_msg:
    mov eax, 4 ; system call for write
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, error
    mov edx, 14 ; length of error
    int 0x80 ; call kernel
    jmp exit

print_result:
    ; Print result
    mov eax, 4 ; system call for write
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, result
    mov edx, 8 ; length
    int 0x80 ; call kernel


    ; Print result
    fstp dword [num1]
    mov eax, 4 ; system call for write
    mov ebx, 1 ; file descriptor for stdout
    mov ecx, num1
    mov edx, 8 ; length of number
    int 0x80 ; call kernel

exit:
; Exit program
    mov eax, 1 ; system call for exit
    xor ebx, ebx ; return value of 0
    int 0x80 ; call kernel