LIB = libSTM32F4_CUBE.a

CC = arm-none-eabi-gcc
AR = arm-none-eabi-ar
RANLIB = arm-none-eabi-ranlib
CMSIS=../../CMSIS
ST=../
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
CFLAGS+=-I../../../Inc
CFLAGS+= \
	-D STM32F429xx \
	-D USE_HAL_DRIVER
SRCS = \
../Src/stm32f4xx_hal_adc.c \
../Src/stm32f4xx_hal_adc_ex.c \
../Src/stm32f4xx_hal.c \
../Src/stm32f4xx_hal_can.c \
../Src/stm32f4xx_hal_cortex.c \
../Src/stm32f4xx_hal_crc.c \
../Src/stm32f4xx_hal_cryp.c \
../Src/stm32f4xx_hal_cryp_ex.c \
../Src/stm32f4xx_hal_dac.c \
../Src/stm32f4xx_hal_dac_ex.c \
../Src/stm32f4xx_hal_dcmi.c \
../Src/stm32f4xx_hal_dma2d.c \
../Src/stm32f4xx_hal_dma.c \
../Src/stm32f4xx_hal_dma_ex.c \
../Src/stm32f4xx_hal_eth.c \
../Src/stm32f4xx_hal_flash.c \
../Src/stm32f4xx_hal_flash_ex.c \
../Src/stm32f4xx_hal_gpio.c \
../Src/stm32f4xx_hal_hash.c \
../Src/stm32f4xx_hal_hash_ex.c \
../Src/stm32f4xx_hal_hcd.c \
../Src/stm32f4xx_hal_i2c.c \
../Src/stm32f4xx_hal_i2c_ex.c \
../Src/stm32f4xx_hal_i2s.c \
../Src/stm32f4xx_hal_i2s_ex.c \
../Src/stm32f4xx_hal_irda.c \
../Src/stm32f4xx_hal_iwdg.c \
../Src/stm32f4xx_hal_ltdc.c \
../Src/stm32f4xx_hal_msp_template.c \
../Src/stm32f4xx_hal_nand.c \
../Src/stm32f4xx_hal_nor.c \
../Src/stm32f4xx_hal_pccard.c \
../Src/stm32f4xx_hal_pcd.c \
../Src/stm32f4xx_hal_pwr.c \
../Src/stm32f4xx_hal_pwr_ex.c \
../Src/stm32f4xx_hal_rcc.c \
../Src/stm32f4xx_hal_rcc_ex.c \
../Src/stm32f4xx_hal_rng.c \
../Src/stm32f4xx_hal_rtc.c \
../Src/stm32f4xx_hal_rtc_ex.c \
../Src/stm32f4xx_hal_sai.c \
../Src/stm32f4xx_hal_sd.c \
../Src/stm32f4xx_hal_sdram.c \
../Src/stm32f4xx_hal_smartcard.c \
../Src/stm32f4xx_hal_spi.c \
../Src/stm32f4xx_hal_sram.c \
../Src/stm32f4xx_hal_tim.c \
../Src/stm32f4xx_hal_tim_ex.c \
../Src/stm32f4xx_hal_uart.c \
../Src/stm32f4xx_hal_usart.c \
../Src/stm32f4xx_hal_wwdg.c \
../Src/stm32f4xx_ll_fmc.c \
../Src/stm32f4xx_ll_fsmc.c \
../Src/stm32f4xx_ll_sdmmc.c \
../Src/stm32f4xx_ll_usb.c


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
