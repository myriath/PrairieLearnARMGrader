.global protectoutputs
// Creates a copy of stdout and points the normal stdout/stderr file descriptors to /dev/null
// Does the same thing as what is done in the start of the c-grader main functionsx.
// int protectoutputs()
protectoutputs:
    push {lr}
    // get new stdout fd
    mov r0, #1
    bl dup
    push {r0} // store new stdout in stack
    // open /dev/null
    ldr r0, =DEV_NULL
    mov r1, #1
    bl open
    push {r0} // store devnull in stack
    // dup2 (devnull, stdout)
    mov r1, #1
    bl dup2
    // dup2 (devnull, stderr
    pop {r0} // pop devnull from stack
    mov r1, #2
    bl dup2
    // return new stdout fd
    pop {r0, pc} // pop new stdout from stack and return

.global dup
// int dup(int fd)
dup:
    push {r4-r7, lr}
    // ensure other args are 0
    mov r1, #0
    mov r2, #0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    // syscall 41
    mov r7, #41
    svc #0
    // return new fd
    pop {r4-r7, pc}

.global dup2
// int dup2(int oldFd, int newFd)
dup2:
    push {r4-r7, lr}
    // ensure other args are 0
    mov r2, #0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    // syscall 63
    mov r7, #63
    svc #0
    // returns something, should be unused tho
    pop {r4-r7, pc}

.global open
// int open(char *filename, int flags)
open:
    push {r4-r7, lr}
    // ensure other args are 0
    mov r2, #0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    // syscall 5
    mov r7, #5
    svc #0
    // return fd
    pop {r4-r7, pc}

.global write
// void write(int fd, char *str, int count)
write:
    push {r4-r7, lr}
    // ensure other args are 0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    // syscall 4
    mov r7, #4
    svc #0
    // return
    pop {r4-r7, pc}

.global exit
// exit(int exitcode)
exit:
    mov r7, #1
    svc #0

DEV_NULL: .asciz "/dev/null"
