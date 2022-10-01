# ======================================================================
#  This Makefile builds an application *.ebf file for Aquila.
#
#  Chun-Jen Tsai, Jan/12/2020
# ======================================================================

CROSS = riscv32-unknown-elf
CCPATH = $(RISCV)/bin

CC = $(CCPATH)/$(CROSS)-gcc
OD = $(CCPATH)/$(CROSS)-objdump
SP = $(CCPATH)/$(CROSS)-strip

LIBC   = ../elibc
LIBNET = ../raw_api
OUT_OBJS = \
	./raw_echo.o \
	$(LIBC)/crt0.o \
	$(LIBC)/stdio.o \
	$(LIBC)/stdlib.o \
	$(LIBC)/string.o \
	$(LIBC)/time.o \
	$(LIBC)/uart.o \
	$(LIBNET)/raw_api.o \

CCFLAGS  = -Wall -O2 -I$(LIBC) -I$(LIBNET) -fomit-frame-pointer -march=rv32im -mstrict-align -fno-builtin -mabi=ilp32 -Wno-unused
LDFLAGS  = -Wl,-Map,$(PROJ).map -T$(PROJ).ld -nostartfiles -static  # -Ttext=0

PROJ = raw_echo

all:
	make $(PROJ).mem

clean:
	rm -rf *.s *.o *.a *.bin *.objdump *.map *.elf *.content *.mem $(OUT_OBJS)

%.o: %.c $(PROJ).ld
	@echo "[Objects] : $@ -----------------------------------------"
	@echo "Building: $<"
	$(CC) $(CCFLAGS) -c $< -o $@
	@echo "Finished Building: $<"

$(PROJ).elf: $(OUT_OBJS)
	@echo '============================================================'
	@echo 'Building target: $@'
	@echo '--------------------------------'
	$(CC) $(LDFLAGS) -o $@ $(OUT_OBJS)
	$(OD) -d $@ > $(PROJ).objdump
	$(SP) $@
	@echo 'Finished building target: $@'
	@echo ' '

$(PROJ).mem: $(PROJ).elf
	./create_mem.sh $<
