#Output files
PROJECT=firmware
EXECUTABLE=$(PROJECT).elf
BIN_IMAGE=$(PROJECT).bin

#============================================================================#

#Cross Compiler
CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy
GDB=arm-none-eabi-gdb
CMSIS=./Drivers/CMSIS
ST=./Drivers/STM32F4xx_HAL_Driver
CHIP_ID=STM32F429xx
OPT=0
#============================================================================#

CFLAGS=-O${OPT} -g -mlittle-endian -mthumb
CFLAGS+=-mcpu=cortex-m4
CFLAGS+=-mfpu=fpv4-sp-d16 -mfloat-abi=hard
CFLAGS+=-ffreestanding -Wall
CFLAGS+=-Wl,-T,./Projects/TrueSTUDIO/TrueStudio\ Configuration/STM32F429ZI_FLASH.ld
CFLAGS+=-mlong-calls 
CFLAGS+=--specs=nano.specs --specs=nosys.specs

CFLAGS+= \
	-D $(CHIP_ID) \
	-D USE_HAL_DRIVER \
	-D "__weak = __attribute__((weak))" \
	-D "__packed = __attribute__((__packed__))"
        
        
LDFLAGS+= \
	-L$(ST)/Build -lSTM32F4_CUBE\
	-lm -lc -lgcc

ARCH=CM4F

#============================================================================#
CFLAGS+=-I./
CFLAGS+=-I./Inc
CFLAGS+=-I$(ST)/Inc
CFLAGS+=-I$(CMSIS)/Include
CFLAGS+=-I$(CMSIS)/Device/ST/STM32F4xx/Include

STARTUP=$(CMSIS)/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f429xx.s

SRC=\
	$(CMSIS)/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c


SRC +=./Src/main.c \
	./Src/i2c.c \
	./Src/fmc.c \
	./Src/gpio.c \
	./Src/ltdc.c \
	./Src/spi.c \
	./Src/stm32f4xx_it.c \
	./Src/usb_otg.c \
	./Src/tim.c
#============================================================================#

#Make all
all:$(BIN_IMAGE)

$(BIN_IMAGE):$(EXECUTABLE)
	@$(OBJCOPY) -O binary $^ $@
	@echo '    OBJCOPY $(BIN_IMAGE)'

STARTUP_OBJ = startup_stm32f429xx.o

$(STARTUP_OBJ): $(STARTUP)
	@$(CC) $(CFLAGS) $^ -c $(STARTUP)
	@echo '    CC $(STARTUP_OBJ)'

$(EXECUTABLE):$(SRC) $(STARTUP_OBJ)
	@$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	@echo '    CC $(EXECUTABLE)'
libSTM32F4_CUBE:
	$(MAKE) -C $(ST)/Build
clean_libSTM32F4_CUBE:
	$(MAKE) -C $(ST)/Build clean
#Make clean
clean:
	rm -rf $(STARTUP_OBJ)
	rm -rf $(EXECUTABLE)
	rm -rf $(BIN_IMAGE)

#Make flash
flash:
	st-flash write $(BIN_IMAGE) 0x8000000

#Make openocd
openocd: flash
	openocd -s /opt/openocd/share/openocd/scripts/ -f ./debug/openocd.cfg

#Make cgdb
cgdb:
	cgdb -d $(GDB) -x ./debug/openocd_gdb.gdb

#Make gdbtui
gdbtui:
	$(GDB) -tui -x ./debug/openocd_gdb.gdb

#Make gdbauto
gdbauto: cgdb
#automatically formate
astyle: 
	astyle -r --exclude=lib  *.c *.h
#============================================================================#

.PHONY:all clean flash openocd gdbauto gdbtui cgdb astyle libSTM32F4_CUBE clean_libSTM32F4_CUBE
