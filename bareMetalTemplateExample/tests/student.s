.global _arithmetic
_arithmetic:
    movw r0, 0x0000
    movt r0, 0x2000

    movw r1, 0x0004
    movt r1, 0x2000

    ldr r2, [r1]
    
    add r2, #1

    str r2, [r0]

    bx lr
