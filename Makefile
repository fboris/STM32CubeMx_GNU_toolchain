#Output files
PROJECT=firmware
EXECUTABLE=$(PROJECT).elf
BIN_IMAGE=$(PROJECT).bin

#============================================================================#

#Cross Compiler
CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy
GDB=arm-none-eabi-gdb
CMSIS=./${PROJECT}/Drivers/CMSIS
ST=./${PROJECT}/Drivers/STM32F4xx_HAL_Driver
OPT=0
CFLAGS_INCLUDE=\
	-I./${PROJECT}/ \
	-I./${PROJECT}/Inc \
	-I$(ST)/Inc \
	-I$(CMSIS)/Include \
	-I$(CMSIS)/Device/ST/STM32F4xx/Include
CFLAGS_DEFINE=\
	-D ${CHIP_ID}xx \
	-D USE_HAL_DRIVER \
	-D "__weak = __attribute__((weak))" \
	-D "__packed = __attribute__((__packed__))"
CFLAGS_NANO_NEW_LIB=\
	--specs=nano.specs --specs=nosys.specs 
#============================================================================#
include mks/board.mk
CFLAGS=-O${OPT} -g -mlittle-endian -mthumb \
	-mcpu=cortex-m4 \
	-mfpu=fpv4-sp-d16 -mfloat-abi=hard \
	-ffreestanding -Wall \
	-Wl,-T,./${PROJECT}/Projects/TrueSTUDIO/${PROJECT}\ Configuration/${CHIP_ID}${SUB_ID}_FLASH.ld \
	-mlong-calls \
	${CFLAGS_INCLUDE} ${CFLAGS_DEFINE} ${CFLAGS_NANO_NEW_LIB} 
        
        
LDFLAGS+= \
	-L./Build -lSTM32F4_CUBE\
	-lm -lc -lgcc

ARCH=CM4F

#============================================================================#


STARTUP=$(CMSIS)/Device/ST/STM32F4xx/Source/Templates/gcc/${STARTUP_NAME}.s

SRC=\
	$(CMSIS)/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c \
	./${PROJECT}/Src/main.c \
	./${PROJECT}/Src/i2c.c \
	./${PROJECT}/Src/gpio.c \
	./${PROJECT}/Src/spi.c \
	./${PROJECT}/Src/stm32f4xx_it.c \
	./${PROJECT}/Src/usb_otg.c \
	./${PROJECT}/Src/tim.c \
	./${PROJECT}/Src/can.c \
	./${PROJECT}/Src/usart.c \
	./${PROJECT}/Src/adc.c
#============================================================================#

#Make all
all:libSTM32F4_CUBE $(BIN_IMAGE) 

$(BIN_IMAGE):$(EXECUTABLE)
	@$(OBJCOPY) -O binary $^ $@
	@echo '    OBJCOPY $(BIN_IMAGE)'

STARTUP_OBJ = ${STARTUP_NAME}.o

$(STARTUP_OBJ): $(STARTUP)
	@$(CC) $(CFLAGS) $^ -c $(STARTUP)
	@echo '    CC $(STARTUP_OBJ)'

$(EXECUTABLE):$(SRC) $(STARTUP_OBJ)
	@$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	@echo '    CC $(EXECUTABLE)'
libSTM32F4_CUBE:
	$(MAKE) -C ./Build
clean_libSTM32F4_CUBE:
	$(MAKE) -C ./Build clean
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
	openocd -s /opt/openocd/share/openocd/scripts/ -f ./openocd.cfg

#Make cgdb
cgdb:
	cgdb -d $(GDB) -x ./openocd_gdb.gdb

#Make gdbtui
gdbtui:
	$(GDB) -tui -x ./openocd_gdb.gdb

#Make gdbauto
gdbauto: cgdb
#automatically formate
astyle: 
	astyle -r --exclude=lib  *.c *.h
#============================================================================#

.PHONY:all clean flash openocd gdbauto gdbtui cgdb astyle libSTM32F4_CUBE clean_libSTM32F4_CUBE
