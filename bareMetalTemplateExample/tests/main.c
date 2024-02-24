// required for bare metal mode
#include "lm3s6965_headers/LM3S6965.h"
/**
 * Calling 'self.generateHeaders()' in tests.py will generate several values up here:
 * RAND_SIZE and RAND_ARRAY are defined based on the generate_rand param
 * global variables a, b, ans_a, and ans_b are defined by macros according to the variables param
 * ans_arithmetic is defined based on the functions param
 */

int RAND_PTR = 0;
int rand() {
    if (RAND_PTR >= RAND_SIZE) {
        RAND_PTR = 0;
    }
    return RAND_ARRAY[RAND_PTR++];
}

extern void _exit_qemu();

void print_uart0(const char *s) {
    while (*s != 0) {
        UART0->DR = (unsigned int)(*s);
        s++;
    }
}

extern void _arithmetic();

void c_entry() {
    // test with 100 random values
    for (int i = 0; i < 100; i++) {
        // rand() gets a random value from the RAND_ARRAY generated in tests.py
        int t = rand();
        a = t;
        ans_a = t;
        t = rand();
        b = t;
        ans_b = t;
        // use generated values and execute both answer and test functions
        ans_arithmetic();
        _arithmetic();
        // test for correctness
        if (a != ans_a || b != ans_b) {
            print_uart0("Fail!\n");
            goto _exit;
        }
    }
    print_uart0("Success!\n");
    _exit:
    _exit_qemu();   // exits QEMU cleanly
}
