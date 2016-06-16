#ifndef SPI_DEVICE_H
#define SPI_DEVICE_H

// SPI Defines
#define SPI_CLOCK_DIV4      0x00
#define SPI_CLOCK_DIV16     0x01
#define SPI_CLOCK_DIV64     0x02
#define SPI_CLOCK_DIV128    0x03
#define SPI_CLOCK_DIV2      0x04
#define SPI_CLOCK_DIV8      0x05
#define SPI_CLOCK_DIV32     0x06
//#define SPI_CLOCK_DIV64   0x07

#define SPI_MODE0           0x00
#define SPI_MODE1           0x04
#define SPI_MODE2           0x08
#define SPI_MODE3           0x0C

#define SPI_MODE_MASK       0x0C  // CPOL = bit 3, CPHA = bit 2 on SPCR
#define SPI_CLOCK_MASK      0x03  // SPR1 = bit 1, SPR0 = bit 0 on SPCR
#define SPI_2XCLOCK_MASK    0x01  // SPI2X = bit 0 on SPSR

#define _CSN                PB4
#define _USI_DO             PB1
#define _USI_DI             PB0
#define _SCK                PB2

#include <stdbool.h>
#include <stdint.h>
#include <avr/pgmspace.h>

// basic spi transmission
extern void spi_begin();
extern void spi_end();
extern uint8_t spi_transfer(uint8_t data);
extern void spi_write(uint8_t reg, uint8_t *data, bool read_data, uint8_t len);
lextern void csn_hi();
extern void csn_low();

#endif // SPI_DEVICE_H