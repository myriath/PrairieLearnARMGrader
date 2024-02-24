all: system.bin system.g.bin

system.bin: system.elf
	arm-none-eabi-objcopy -O binary system.elf system.bin

system.elf: lm3s6965.ld main.o startup.o student.o
	arm-none-eabi-ld -T lm3s6965.ld main.o student.o startup.o -o system.elf

student.o: student.s
	arm-none-eabi-as -mcpu=cortex-m3 -g student.s -o student.o

main.o: main.c
	arm-none-eabi-gcc -c -mcpu=cortex-m3 main.c -o main.o

startup.o: startup.s
	arm-none-eabi-as -mcpu=cortex-m3 startup.s -o startup.o

run: system.bin
	qemu-system-arm -M lm3s6965evb -semihosting -nographic -kernel system.bin

system.g.bin: system.g.elf
	arm-none-eabi-objcopy -O binary system.g.elf system.g.bin

system.g.elf: lm3s6965.ld main.g.o startup.g.o student.g.o
	arm-none-eabi-ld -T lm3s6965.ld main.g.o student.g.o startup.g.o -o system.g.elf

student.g.o: student.s
	arm-none-eabi-as -mcpu=cortex-m3 -g student.s -o student.g.o

main.g.o: main.c
	arm-none-eabi-gcc -c -mcpu=cortex-m3 -g main.c -o main.g.o

startup.g.o: startup.s
	arm-none-eabi-as -mcpu=cortex-m3 -g startup.s -o startup.g.o

dbg: system.g.bin
	qemu-system-arm -M lm3s6965evb -semihosting -nographic -kernel system.g.bin -s -S

clean:
	rm *.o
	rm *.elf
	rm *.bin
