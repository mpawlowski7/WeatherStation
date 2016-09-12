MCU := attiny85
CC := /usr/bin/avr-gcc
CFLAGS := -g -Os -Wall -mcall-prologues -mmcu=$(MCU)
OBJ2HEX := /usr/bin/avr-objcopy
TARGET := outside
OBJDIR := bin
OBJS := main.o nrf24.o spi_device.o

.PHONY: all clean

all: $(TARGET)
	$(OBJ2HEX) -R .eeprom -O ihex $(TARGET) $(TARGET).hex
	rm -f $(TARGET)
	mv *.o bin	
	mv $(TARGET).hex bin
	
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(OBJS): | $(OBJDIR)

$(OBJDIR):
	mkdir $(OBJDIR)

clean:
	rm -f bin/*.hex bin/*.o

install:
	scp bin/$(TARGET).hex pi@192.168.60.210:~/