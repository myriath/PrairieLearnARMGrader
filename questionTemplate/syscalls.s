.data
.align 4
RAND_FD: .word 0

.section .text
.global open_rand
// void open_rand()
// Opens /dev/urandom and stores the fd in RAND_FD
open_rand:
    push {r4-r7, lr}
    // open /dev/urandom
    ldr r0, =DEV_RAND
    mov r1, #0 // O_RONLY
    mov r2, #4 // Read by others
    bl open

    ldr r1, =RAND_FD
    str r0, [r1] // store /dev/urandom fd
    // return
    pop {r4-r7, pc}

.global close_rand
// void close_rand()
// Closes /dev/urandom and clears RAND_FD
close_rand:
    push {r4-r7, lr}
    ldr r4, =RAND_FD
    // close /dev/urandom
    ldr r0, [r4]
    bl close

    mov r2, #0
    str r2, [r4] // clear RAND_FD
    // return
    pop {r4-r7, pc}

.global rand
// Reads a single word from /dev/urandom and stores it into the RANDOM_WORD variable.
// int rand()
// returns the random value in r0
rand:
    push {lr}

    // read a word
    ldr r0, =RAND_FD
    ldr r0, [r0] // rand fd

    mov r1, #0
    push {r1}  // make room for read
    mov r1, sp // stack is the pointer

    mov r2, #1 // read one word
    bl read
    // check if we read 4 bytes
    cmp r0, #1
    beq _rand_else
    mov r0, #0
    sub r0, #1  // exit code -1
    b exit 
_rand_else:
    // return random value
    pop {r0, pc}

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
    mov r1, #1 // O_WONLY
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

// ------------ BEGIN SYSCALL FUNCTIONS ----------- //

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
// int open(char *filename, int flags, mode_t mode)
open:
    push {r4-r7, lr}
    // ensure other args are 0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    // syscall 5
    mov r7, #5
    svc #0
    // return fd
    pop {r4-r7, pc}

.global close
// int close(int fd)
close:
    push {r4-r7, lr}
    // ensure other args are 0
    mov r1, #0
    mov r2, #0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    // syscall 6
    mov r7, #6
    svc #0
    // return error codes or 0
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

.global read
// Reads count bytes from fd file descriptor and places it into buf
// size_t read(int fd, void buf[count], size_t count)
read:
    push {r4-r7, lr}
    // ensure other args are 0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    // syscall 3 
    mov r7, #3
    svc #0
    // return
    pop {r4-r7, pc}

.global exit
// exit(int exitcode)
exit:
    bl close_rand   // close random
    mov r7, #1
    svc #0          // exit

DEV_NULL: .asciz "/dev/null"
DEV_RAND: .asciz "/dev/urandom"
