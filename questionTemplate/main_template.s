.data
.align 4
STDOUT: .word 0     // holds file descriptor for stdout

// ------------- BEGIN TESTING VARS ------------- //

// -------------- END TESTING VARS -------------- //

.section .text
.global _start

_start:
    // always call these!
    bl open_rand        // open /dev/urandom and store the fd for rand() calls
    bl protectoutputs   // redirect stdout & stderr to /dev/null and return duped stdout fd
    ldr r1, =STDOUT
    str r0, [r1]    // STDOUT holds fd for stdout now

    // ------------- BEGIN CODE TESTING ------------- //

    // ------------- END CODE TESTING ------------- //
    
    // testing was successful! print message and exit
    b success_exit

// ------------- BEGIN ANSWER FUNCTIONS ------------- //

// -------------- END ANSWER FUNCTIONS -------------- //

// Prints the success message before exiting
success_exit:
    ldr r0, =STDOUT
    ldr r0, [r0]
    ldr r1, =success_msg
    ldr r2, =s_len
    bl write

    b exit

success_msg: .ascii "Success!\n"
s_len = . - success_msg

// Prints the error message before exiting
// Call when testing fails
error_exit:
    ldr r0, =STDOUT
    ldr r0, [r0]
    ldr r1, =error_msg
    ldr r2, =e_len
    bl write

    b exit

error_msg: .ascii "Error!\n"
e_len = . - error_msg
