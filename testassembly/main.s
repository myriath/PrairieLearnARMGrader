.data
.align 4
STDOUT: .word 0


.section .text
.global _start

_start:
    bl protectoutputs
    ldr r1, =STDOUT
    strb r0, [r1] // STDOUT holds fd for stdout now

    ldr r0, =STDOUT
    ldr r0, [r0]
    ldr r1, =msg
    ldr r2, =len
    bl write
    mov r0, #1
    ldr r1, =msg
    ldr r2, =len
    bl write
    b exit

msg: .ascii "Hello, ARM32!\n"
len = . - msg

inputsfn: .asciz "readme.txt"
