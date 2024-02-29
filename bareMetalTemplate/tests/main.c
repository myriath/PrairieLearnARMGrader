// required for bare metal mode
#include "lm3s6965_headers/LM3S6965.h"
#include "io.h"

#define NUM_INPUTS 5

// functions inserted here

// replaced by generateHeaders()
#define RAND_SIZE 1
// replaced by generateHeaders()
int RAND_ARRAY[RAND_SIZE];

int RAND_PTR = 0;
int rand() {
    if (RAND_PTR >= RAND_SIZE) {
        RAND_PTR = 0;
    }
    return RAND_ARRAY[RAND_PTR++];
}

extern void _exit_qemu();

// ---------- STUDENT FUNCTION DECLARATIONS ---------- //
// Example:
// extern void _arithmetic();           // Student function label is _arithmetic



// ---------- GLOBAL VARIABLE DECLARATIONS ---------- //
// These get replaced by generateHeaders() with actual variable definitions
// Example: 
// #define a *((int *) 0)   // Only need to change the variable name ('a' here).




void c_entry() {
    // ---------- READ INPUTS ---------- //
    // Example:
    // int as[NUM_INPUTS];      // Fills this array with NUM_INPUTS inputs
    // int *aptr = as;
    // for (int i = 0; i < NUM_INPUTS; i++) {
    //     scan_uart0("%d", aptr);
    //     aptr++;
    // }


    // ---------- RUN STUDENT CODE ---------- //
    // Example:
    // for (int i = 0; i < NUM_INPUTS; i++) {
    //     a = as[i];                       
    //     _arithmetic();                   // Student function is _arithmetic()
    //     print_uart0("a=%d\n", a, b);     // Print output
    // }

    _exit_qemu();   // exits QEMU cleanly
}
