# makefile for arm gcc toolchain

# Can be set by family, default to ARM GCC
CROSS_COMPILE ?= arm-none-eabi-

CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++
AS = $(CC) -x assembler-with-cpp
LD = $(CC)

GDB = $(CROSS_COMPILE)gdb
OBJCOPY = $(CROSS_COMPILE)objcopy
SIZE = $(CROSS_COMPILE)size
#TODO: look into whether this is a good idea or not, or set uniquely for tinyusb, and not the rest
# CFLAGS += \
#   -fsingle-precision-constant \

LIBS += -lgcc -lm -lnosys

include ${TOP}/examples/build_system/make/toolchain/gcc_common.mk
