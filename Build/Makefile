PROJECT=firmware
LIB = libSTM32F4_CUBE.a
CC = arm-none-eabi-gcc
AR = arm-none-eabi-ar
RANLIB = arm-none-eabi-ranlib
CMSIS=../${PROJECT}/Drivers/CMSIS
ST=../${PROJECT}/Drivers/STM32F4xx_HAL_Driver

#board definition
CHIP_ID=STM32F429
SUB_ID=ZI
#============================================================================

CFLAGS=-g -mlittle-endian -mthumb
CFLAGS+=-mcpu=cortex-m4
CFLAGS+=-mfpu=fpv4-sp-d16 -mfloat-abi=hard
CFLAGS+=-ffreestanding -Wall
CFLAGS+=-mlong-calls 
CFLAGS+=-nostdlib
CFLAGS+=-O1

CFLAGS+=-I$(ST)/Inc
CFLAGS+=-I$(CMSIS)/Include
CFLAGS+=-I$(CMSIS)/Device/ST/STM32F4xx/Include
CFLAGS+=-I../${PROJECT}/Inc
CFLAGS+= \
	-D STM32F429xx \
	-D USE_HAL_DRIVER
SRCS = \
${ST}/Src/stm32f4xx_hal_adc.c \
${ST}/Src/stm32f4xx_hal_adc_ex.c \
${ST}/Src/stm32f4xx_hal.c \
${ST}/Src/stm32f4xx_hal_can.c \
${ST}/Src/stm32f4xx_hal_cortex.c \
${ST}/Src/stm32f4xx_hal_crc.c \
${ST}/Src/stm32f4xx_hal_cryp.c \
${ST}/Src/stm32f4xx_hal_cryp_ex.c \
${ST}/Src/stm32f4xx_hal_dac.c \
${ST}/Src/stm32f4xx_hal_dac_ex.c \
${ST}/Src/stm32f4xx_hal_dcmi.c \
${ST}/Src/stm32f4xx_hal_dma2d.c \
${ST}/Src/stm32f4xx_hal_dma.c \
${ST}/Src/stm32f4xx_hal_dma_ex.c \
${ST}/Src/stm32f4xx_hal_eth.c \
${ST}/Src/stm32f4xx_hal_flash.c \
${ST}/Src/stm32f4xx_hal_flash_ex.c \
${ST}/Src/stm32f4xx_hal_gpio.c \
${ST}/Src/stm32f4xx_hal_hash.c \
${ST}/Src/stm32f4xx_hal_hash_ex.c \
${ST}/Src/stm32f4xx_hal_hcd.c \
${ST}/Src/stm32f4xx_hal_i2c.c \
${ST}/Src/stm32f4xx_hal_i2c_ex.c \
${ST}/Src/stm32f4xx_hal_i2s.c \
${ST}/Src/stm32f4xx_hal_i2s_ex.c \
${ST}/Src/stm32f4xx_hal_irda.c \
${ST}/Src/stm32f4xx_hal_iwdg.c \
${ST}/Src/stm32f4xx_hal_ltdc.c \
${ST}/Src/stm32f4xx_hal_msp_template.c \
${ST}/Src/stm32f4xx_hal_nand.c \
${ST}/Src/stm32f4xx_hal_nor.c \
${ST}/Src/stm32f4xx_hal_pccard.c \
${ST}/Src/stm32f4xx_hal_pcd.c \
${ST}/Src/stm32f4xx_hal_pwr.c \
${ST}/Src/stm32f4xx_hal_pwr_ex.c \
${ST}/Src/stm32f4xx_hal_rcc.c \
${ST}/Src/stm32f4xx_hal_rcc_ex.c \
${ST}/Src/stm32f4xx_hal_rng.c \
${ST}/Src/stm32f4xx_hal_rtc.c \
${ST}/Src/stm32f4xx_hal_rtc_ex.c \
${ST}/Src/stm32f4xx_hal_sai.c \
${ST}/Src/stm32f4xx_hal_sd.c \
${ST}/Src/stm32f4xx_hal_sdram.c \
${ST}/Src/stm32f4xx_hal_smartcard.c \
${ST}/Src/stm32f4xx_hal_spi.c \
${ST}/Src/stm32f4xx_hal_sram.c \
${ST}/Src/stm32f4xx_hal_tim.c \
${ST}/Src/stm32f4xx_hal_tim_ex.c \
${ST}/Src/stm32f4xx_hal_uart.c \
${ST}/Src/stm32f4xx_hal_usart.c \
${ST}/Src/stm32f4xx_hal_wwdg.c \
${ST}/Src/stm32f4xx_ll_fmc.c \
${ST}/Src/stm32f4xx_ll_fsmc.c \
${ST}/Src/stm32f4xx_ll_sdmmc.c \
${ST}/Src/stm32f4xx_ll_usb.c


OBJS = $(SRCS:.c=.o)

all: $(LIB)

$(LIB): $(OBJS)
	$(AR) -r $(LIB) $(OBJS)
	$(RANLIB) $(LIB)

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $^

clean:
	-rm -f $(OBJS)
	-rm -f $(LIB)

.PHONY: all clean
