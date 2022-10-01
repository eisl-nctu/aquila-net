# ======================================================================
#  This Makefile builds a LWIP application *.elf for Aquila.
# ======================================================================

LWIP_DIR = ../lwip/src
FREERTOS_DIR = ../FreeRTOS
LIBC = ../elibc
BUILD_DIR = ./build

# FreeRTOS seeting -------------------------------------------------------------
FREERTOS_SOURCE_DIR = $(FREERTOS_DIR)/Source

FREERTOS_SRC = \
	$(FREERTOS_SOURCE_DIR)/list.c \
	$(FREERTOS_SOURCE_DIR)/queue.c \
	$(FREERTOS_SOURCE_DIR)/tasks.c \
	$(FREERTOS_SOURCE_DIR)/portable/MemMang/heap_3.c \
	$(FREERTOS_SOURCE_DIR)/timers.c \
	$(FREERTOS_SOURCE_DIR)/event_groups.c
#	$(FREERTOS_SOURCE_DIR)/croutine.c \
	$(FREERTOS_SOURCE_DIR)/stream_buffer.c

FREERTOS_INCLUDES := -I $(FREERTOS_SOURCE_DIR)/include

FREERTOS_BUILD_DIR = $(BUILD_DIR)/FreeRTOS
FREERTOS_OBJS = $(patsubst %.c,$(FREERTOS_BUILD_DIR)/%.o,$(notdir $(FREERTOS_SRC)))

VPATH += \
	$(FREERTOS_SOURCE_DIR) \
	$(FREERTOS_SOURCE_DIR)/portable/MemMang

# Platform spcific FreeRTOS settings for this application ----------------------
ARCH = RISC-V
ARCH_PORTABLE_INC = $(FREERTOS_SOURCE_DIR)/portable/GCC/$(ARCH)/
ARCH_PORTABLE_SRC = $(FREERTOS_SOURCE_DIR)/portable/GCC/$(ARCH)/port.c
ARCH_PORTABLE_ASM = $(FREERTOS_SOURCE_DIR)/portable/GCC/$(ARCH)/portASM.S

PORT_OBJS := $(patsubst %.c,$(FREERTOS_BUILD_DIR)/%.o,$(notdir $(ARCH_PORTABLE_SRC)))
PORT_OBJS += $(patsubst %.S,$(FREERTOS_BUILD_DIR)/%.o,$(notdir $(ARCH_PORTABLE_ASM)))
FREERTOS_OBJS += $(PORT_OBJS)

VPATH += $(FREERTOS_SOURCE_DIR)/portable/GCC/$(ARCH)

# LWIP
# COREFILES, CORE4FILES: The minimum set of files needed for lwIP.
COREFILES = \
	$(LWIP_DIR)/core/init.c \
	$(LWIP_DIR)/core/def.c \
	$(LWIP_DIR)/core/dns.c \
	$(LWIP_DIR)/core/inet_chksum.c \
	$(LWIP_DIR)/core/ip.c \
	$(LWIP_DIR)/core/mem.c \
	$(LWIP_DIR)/core/memp.c \
	$(LWIP_DIR)/core/netif.c \
	$(LWIP_DIR)/core/pbuf.c \
	$(LWIP_DIR)/core/raw.c \
	$(LWIP_DIR)/core/stats.c \
	$(LWIP_DIR)/core/sys.c \
	$(LWIP_DIR)/core/altcp.c \
	$(LWIP_DIR)/core/altcp_alloc.c \
	$(LWIP_DIR)/core/altcp_tcp.c \
	$(LWIP_DIR)/core/tcp.c \
	$(LWIP_DIR)/core/tcp_in.c \
	$(LWIP_DIR)/core/tcp_out.c \
	$(LWIP_DIR)/core/timeouts.c \
	$(LWIP_DIR)/core/udp.c

CORE4FILES = \
	$(LWIP_DIR)/core/ipv4/autoip.c \
	$(LWIP_DIR)/core/ipv4/dhcp.c \
	$(LWIP_DIR)/core/ipv4/etharp.c \
	$(LWIP_DIR)/core/ipv4/icmp.c \
	$(LWIP_DIR)/core/ipv4/igmp.c \
	$(LWIP_DIR)/core/ipv4/ip4_frag.c \
	$(LWIP_DIR)/core/ipv4/ip4.c \
	$(LWIP_DIR)/core/ipv4/ip4_addr.c

# APIFILES: The files which implement the sequential and socket APIs.
APIFILES = \
	$(LWIP_DIR)/api/api_lib.c \
	$(LWIP_DIR)/api/api_msg.c \
	$(LWIP_DIR)/api/err.c \
	$(LWIP_DIR)/api/if_api.c \
	$(LWIP_DIR)/api/netbuf.c \
	$(LWIP_DIR)/api/netdb.c \
	$(LWIP_DIR)/api/netifapi.c \
	$(LWIP_DIR)/api/sockets.c \
	$(LWIP_DIR)/api/tcpip.c

# NETIFFILES: Files implementing various generic network interface functions
NETIFFILES = \
	$(LWIP_DIR)/netif/ethernet.c \
	$(LWIP_DIR)/netif/bridgeif.c \
	$(LWIP_DIR)/netif/bridgeif_fdb.c \

PORTSFILES = \
	$(LWIP_DIR)/ports/aquila/driver/aquila_lwip_driver.c \
	$(LWIP_DIR)/ports/aquila/driver/eth.c \
	$(LWIP_DIR)/ports/aquila/sys_arch.c \

# LWIPNOAPPSFILES: All LWIP files without apps
LWIPNOAPPSFILES = \
	$(COREFILES) \
	$(CORE4FILES) \
	$(APIFILES) \
	$(NETIFFILES) \
	$(PORTSFILES) \

LWIP_BUILD_DIR = $(BUILD_DIR)/lwip
LWIP_OBJS := $(patsubst %.c,$(LWIP_BUILD_DIR)/%.o,$(notdir $(LWIPNOAPPSFILES)))
LWIP_INCLUDES = \
	-I ./ \
	-I $(LWIP_DIR)/include/ \
	-I $(LWIP_DIR)/include/netif \
	-I $(LWIP_DIR)/ports/aquila/driver \
	-I $(LWIP_DIR)/ports/aquila/include \
	-I $(FREERTOS_SOURCE_DIR)/include \
	-I $(ARCH_PORTABLE_INC) \
	
VPATH += \
	$(LWIP_DIR)/core \
	$(LWIP_DIR)/core/ipv4 \
	$(LWIP_DIR)/api \
	$(LWIP_DIR)/netif \
	$(LWIP_DIR)/ports/aquila/driver \
	$(LWIP_DIR)/ports/aquila \


# Application source, include, and object files for compilation ----------------
APP_SRC_DIR = .
APP_SRC = \
	$(APP_SRC_DIR)/socket_echo.c

LIB_SRC = \
	$(LIBC)/crt0.c \
	$(LIBC)/stdio.c \
	$(LIBC)/stdlib.c \
	$(LIBC)/string.c \
	$(LIBC)/uart.c \

APP_INCLUDES = \
	-I ./ \
	-I $(LIBC) \
	-I $(LWIP_DIR)/include/ \
	-I $(LWIP_DIR)/include/netif \
	-I $(LWIP_DIR)/ports/aquila/driver \
	-I $(LWIP_DIR)/ports/aquila/include \
	-I $(FREERTOS_SOURCE_DIR)/include \
	-I $(ARCH_PORTABLE_INC)


LIB_INCLUDES = \
	-I $(LIBC)

APP_BUILD_DIR = $(BUILD_DIR)/app
APP_OBJS := $(patsubst %.c,$(APP_BUILD_DIR)/%.o,$(notdir $(APP_SRC)))

LIB_BUILD_DIR = $(BUILD_DIR)/lib
LIB_OBJS := $(patsubst %.c,$(LIB_BUILD_DIR)/%.o,$(notdir $(LIB_SRC)))

VPATH += $(APP_SRC_DIR) $(LIBC)

# Add application & platform-specific include paths for FreeRTOS ---------------
FREERTOS_INCLUDES += \
	-I ./ \
	-I $(ARCH_PORTABLE_INC) \
	-I $(FREERTOS_SOURCE_DIR)/portable/GCC/RISC-V/chip_specific_extensions/RV32I_CLINT_no_extensions

# List of object files to compile for the system -------------------------------
OUT_OBJS = \
	$(APP_OBJS) \
	$(LIB_OBJS) \
	$(LWIP_OBJS) \
	$(FREERTOS_OBJS) \

BUILD_DIRECTORIES = \
	$(APP_BUILD_DIR) \
	$(LIB_BUILD_DIR) \
	$(LWIP_BUILD_DIR) \
	$(FREERTOS_BUILD_DIR) \

# RISC-V compile tool
CROSS = riscv32-unknown-elf
CCPATH = $(RISCV)/bin

CC = $(CCPATH)/$(CROSS)-gcc
AS = $(CCPATH)/$(CROSS)-as
LD = $(CCPATH)/$(CROSS)-ld
OD = $(CCPATH)/$(CROSS)-objdump
SP = $(CCPATH)/$(CROSS)-strip

CFLAGS += -Wall -O2 -fomit-frame-pointer -march=rv32im -mstrict-align -fno-builtin -mabi=ilp32
ASMFLAGS = -march=rv32im -DportasmHANDLE_INTERRUPT=main
LDFLAGS = -Wl,-Map,"$(BUILD_DIR)/$(PROJ).map" -T$(PROJ).ld -nostartfiles -static  # -Ttext=0

PROJ = socket_echo
OUT_ELF = ./$(PROJ).elf

.PHONY: clean directories app_compile frtos_compile out_elf
all: directories $(OUT_OBJS) $(OUT_ELF)
directories: $(BUILD_DIRECTORIES)
app_compile: directories $(APP_OBJS) $(LIB_OBJS)
frtos_compile: directories $(FREERTOS_OBJS)
out_elf: directories $(OUT_ELF)

# Compile Object Files ---------------------------------------------------------
$(APP_BUILD_DIR)/%.o : %.c
	@echo "[APP Objects] : $@ -----------------------------------------"
	@echo "Building: $<"
	$(CC) $(CFLAGS) $(APP_INCLUDES) -o $@ -c $<
	@echo "Finished Building: $<"

$(LIB_BUILD_DIR)/%.o : %.c
	@echo "[LIB Objects] : $@ -----------------------------------------"
	@echo "Building: $<"
	$(CC) $(CFLAGS) $(LIB_INCLUDES) -o $@ -c $<
	@echo "Finished Building: $<"

$(LWIP_BUILD_DIR)/%.o : %.c
	@echo "[LWIP Objects] : $@ -----------------------------------------"
	@echo "Building: $<"
	$(CC) $(CFLAGS) $(LWIP_INCLUDES) -o $@ -c $<
	@echo "Finished Building: $<"

$(FREERTOS_BUILD_DIR)/%.o : %.c
	@echo "[FreeRTOS Objects] : $@ ------------------------------------"
	@echo "Building: $<"
	$(CC) $(CFLAGS) $(FREERTOS_INCLUDES) -o $@ -c $<
	@echo "Finished Building: $<"

$(FREERTOS_BUILD_DIR)/%.o : %.S
	@echo "[FreeRTOS Objects] : $@ -----------------------------------------"
	@echo "Building: $<"
	$(CC) $(ASMFLAGS) $(FREERTOS_INCLUDES) -o $@ -c $<
	@echo "Finished Building: $<"

# Generate ELF -----------------------------------------------------------------
$(OUT_ELF): $(OUT_OBJS)
	@echo '============================================================'
	@echo 'Building target: $@'
	@echo '--------------------------------'
	$(CC) $(LDFLAGS) -o $@ $(OUT_OBJS)
	$(OD) -d $@ > $(BUILD_DIR)/$(PROJ).objdump
	$(SP) $@
	@echo 'Finished building target: $@'
	@echo ' '

$(BUILD_DIRECTORIES):
	mkdir -p $@

clean:
	rm -rf *.elf
	rm -rf $(BUILD_DIR)
