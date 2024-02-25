.data
.align 4
STDOUT: .word 0     // holds file descriptor for stdout

// ------------- BEGIN TESTING VARS ------------- //

// -------------- END TESTING VARS -------------- //

.section .text

// Available functions:
// void open_rand()                                     Opens /dev/urandom. Must be called before any rand() calls
// void close_rand()                                    Closes /dev/urandom. Must be called before the program exits
// int  rand()                                          Generate a random byte and return it as r0
// int  protectoutputs()                                Protects stdout and stderr from student use. Should be called at the start of the program. Returns the new stdout file descriptor in r0
// 
// int  dup(int fd)                                     Performs a syscall to duplicate the given file descriptor. Returns the new file descriptor in r0
// int  dup2(int oldFd, int newFd)                      Performs a syscall to move the old file descriptor into the new file descriptor. Returns error codes in r0
// int  open(char *filename, int flags, mode_t mode)    Performs a syscall to open the given file path with the given file flags and mode. Read ubuntu manual for valid flags and modes
// int  close(int fd)                                   Performs a syscall to close the given file descriptor. Returns error codes in r0
// void write(int fd, byte buf[count], int count)       Performs a syscall to write [count] bytes from buf to the given file descriptor.
// void read(int fd, byte buf[count], int count)        Performs a syscall to read [count] bytes from the file descriptor into buf.
// void exit(int code)                                  Calls close_rand() then exits the program with the given exit code.

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
