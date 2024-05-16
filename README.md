
# PrairieLearnARMGrader

PrairieLearn auto-grader for ARM assembly-based questions. Works similarly to the C autograder maintained by PrairieLearn.

The auto-grader is fully functional with specialized commands for autograding ARM assembly.

## Writeups

There are two writeups detailing the ARM assembly autograder. The first outlines basic ARM assembly auto-grading through QEMU emulating a Linux system. This works fine for most cases, but doesn't allow for statically placed variables in memory, which was needed for the class. To fix this, we also created another version of the emulator that uses QEMU in bare-metal mode, where the code is compiled into a kernel to use directly with an emulated machine. Another writeup was created for this functionality, as it differs significantly from the standard form.

* [Basic ARM Assembly Auto-Grader](https://git.ece.iastate.edu/class/ece-prairielearn-documentation/-/blob/main/sdmay24-33/writeups/pdf/PrairieLearn%20QEMU%20ARM%20Autograder%20Writeup.pdf?ref_type=heads)
* [Bare-Metal ARM Assembly Auto-Grader](https://git.ece.iastate.edu/class/ece-prairielearn-documentation/-/blob/main/sdmay24-33/writeups/pdf/PrairieLearn%20QEMU%20ARM%20Bare-Metal%20Autograder%20Writeup.pdf?ref_type=heads)
