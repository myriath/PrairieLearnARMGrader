extern void _exit_qemu();
volatile unsigned int * const UART0DR = (unsigned int *) 0x4000c000;

void print_uart0(const char *s) {
    while (*s != 0) {
        *UART0DR = (unsigned int)(*s);
        s++;
    }
}

extern void _arithmetic();

volatile unsigned int * const a = (unsigned int *) 0x20000000;
volatile unsigned int * const b = (unsigned int *) 0x20000004;
volatile unsigned int * const ans_a = (unsigned int *) 0x2000f000;
volatile unsigned int * const ans_b = (unsigned int *) 0x2000f004;

void ans_arithmetic() {
    *ans_a = *ans_b + 1;
}

void c_entry() {
    *a = 44;
    *ans_a = 44;
    *b = 52;
    *ans_b = 52;
    ans_arithmetic();
    _arithmetic();

    if (*a == *ans_a && *b == *ans_b) {
        print_uart0("Success!\n");
    } else {
        print_uart0("Fail!\n");
    }
    _exit_qemu();   // exits QEMU cleanly
}
