import armgrader
import random

class TestGrader(armgrader.ARMGrader):
    def tests(self):
        self.generateHeaders(
            # sets main file to add these headers to
            main_file="/grade/tests/main.c", # default /grade/tests/main.c
            # fill in variables in the c code
            memory_map=self.data['params']['memoryMap']
        )
        
        # compiles the program. student_file is the name of the student's code file, it gets copied to /grade/tests for compilation
        self.make(student_file="student.s")
        # runs the program and tests against exp_output. you can use the same arguments as any other test_run call.
        input = []
        exp_output = []
        add_amnt = self.data['params']['add_amnt']
        for _ in range(5):
            a = random.randint(0, 255)
            b = random.randint(0, 255)
            ans_a = b+add_amnt
            exp_output.append(f"a={ans_a} b={b}\n")
            input.append(f'{a} {b}')
        self.test_make_run(input="\n".join(input), exp_output=exp_output, highlight_matches=True)
    
g = TestGrader()
g.start()
