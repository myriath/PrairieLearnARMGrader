import armgrader
import random

class TestGrader(armgrader.ARMGrader):
    def tests(self):
        self.generateHeaders(
            # sets main file to add these headers to
            main_file="/grade/tests/main.c", # default /grade/tests/main.c
            # generates a RAND_ARRAY of 256 random numbers
            generate_rand=256, # default 256
            # a and b are given actual addresses      ans_a/ans_b are randomly gen
            # randomly generated values are 0x2000f000 - 0x2000ffff, do not use these for predefined values!
            variables={
                'a':self.data["params"]["a_adr"],
                'b':self.data["params"]["b_adr"],
                'ans_a':None,
                'ans_b':None
            },
            # fills in any additional functions, doesn't have to just be answers
            # here we write the code for the answer function, since it depends on the amount to add in params
            functions=[
                f'''
                void ans_arithmetic() {{ // these double brackets escape the bracket symbol for f-strings
                    ans_a = ans_b + {self.data["params"]["add_amnt"]};
                }}
                '''
            ]
        )
        
        # compiles the program. student_file is the name of the student's code file, it gets copied to /grade/tests for compilation
        self.make(student_file="student.s")
        # runs the program and tests against exp_output. you can use the same arguments as any other test_run call.
        self.test_make_run(exp_output="Success!\n")
    
g = TestGrader()
g.start()
