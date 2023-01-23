section .data
    prompt db 'Choose Operation', 0xa ,'1 -> Add', 0xa ,'2 -> Subtract' ,0xa ,'3 -> Multiply' ,0xa ,'4 -> Divide:', 0xa
    lenp equ $ - prompt
    prompt2 db 'Enter Number 1:', 0xa
    len2 equ $ - prompt2
    prompt3 db 'Enter Number 2:', 0xa
    len3 equ $ - prompt3
    prompt4 db 'Result:', 0xa
    len4 equ $ - prompt4

section .bss
    oper: resb 1
    num1: resb 4
    num2: resb 4
    result: resb 4

section .text
    global _start

_start:
    mov dword [num1], __float32__(0.00)
    mov dword [num2], __float32__(0.00)
   
    ; CHOOSE NUM1 PROMPT
    mov edx, len2 
    mov ecx, prompt2
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num1 
    mov edx, 4
    int 0x80

    ; CHOOSE NUM2 PROMPT
    mov edx, len3 
    mov ecx, prompt3
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80

    ; CHOOSE OPERATOR PROMPT
    mov edx, lenp
    mov ecx, prompt
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, oper
    mov edx, 1
    int 0x80

    cmp ecx, 1
    je addr

    cmp ecx, 2
    je subr

    cmp ecx, 3
    je mulr

    cmp ecx, 4
    je divr

    addr:
        mov eax, [num1]
        sub eax, '0'
        mov ebx, [num2]
        sub ebx, '0'
        add eax, ebx
        add eax, '0'
        mov [result], eax
        mov edx, len4
        mov ecx, prompt4
        mov ebx, 1
        mov eax, 4
        int 0x80

        mov edx, 3
        mov ecx, result
        mov ebx, 1
        mov eax, 4
        int 0x80
        mov eax, 1
        mov ebx, 0
        int 0x80
        jmp exit

    subr:
    mulr:
    divr:


    exit:
    mov edx, 1
    mov ecx, 0xa
    mov ebx, 1
    mov eax, 4
    int 0x80
    mov eax, 1
    mov ebx, 0
    int 0x80