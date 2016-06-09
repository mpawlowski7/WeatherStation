
#ifndef NRF24_H
#define NRF24_H

#include <stdio.h>
#include <avr/pgmspace.h>
#include <stdbool.h>

// SPI Defines
#define SPI_CLOCK_DIV4 0x00
#define SPI_CLOCK_DIV16 0x01
#define SPI_CLOCK_DIV64 0x02
#define SPI_CLOCK_DIV128 0x03
#define SPI_CLOCK_DIV2 0x04
#define SPI_CLOCK_DIV8 0x05
#define SPI_CLOCK_DIV32 0x06
//#define SPI_CLOCK_DIV64 0x07

#define SPI_MODE0 0x00
#define SPI_MODE1 0x04
#define SPI_MODE2 0x08
#define SPI_MODE3 0x0C

#define SPI_MODE_MASK 0x0C  // CPOL = bit 3, CPHA = bit 2 on SPCR
#define SPI_CLOCK_MASK 0x03  // SPR1 = bit 1, SPR0 = bit 0 on SPCR
#define SPI_2XCLOCK_MASK 0x01  // SPI2X = bit 0 on SPSR

// Memory Map
#define CONFIG      0x00
#define EN_AA       0x01
#define EN_RXADDR   0x02
#define SETUP_AW    0x03
#define SETUP_RETR  0x04
#define RF_CH       0x05
#define RF_SETUP    0x06
#define STATUS      0x07
#define OBSERVE_TX  0x08
#define CD          0x09
#define RX_ADDR_P0  0x0A
#define RX_ADDR_P1  0x0B
#define RX_ADDR_P2  0x0C
#define RX_ADDR_P3  0x0D
#define RX_ADDR_P4  0x0E
#define RX_ADDR_P5  0x0F
#define TX_ADDR     0x10
#define RX_PW_P0    0x11
#define RX_PW_P1    0x12
#define RX_PW_P2    0x13
#define RX_PW_P3    0x14
#define RX_PW_P4    0x15
#define RX_PW_P5    0x16
#define FIFO_STATUS 0x17
#define DYNPD       0x1C
#define FEATURE     0x1D

// Bit Mnemonics
#define MASK_RX_DR  6
#define MASK_TX_DS  5
#define MASK_MAX_RT 4
#define EN_CRC      3
#define CRCO        2
#define PWR_UP      1
#define PRIM_RX     0
#define ENAA_P5     5
#define ENAA_P4     4
#define ENAA_P3     3
#define ENAA_P2     2
#define ENAA_P1     1
#define ENAA_P0     0
#define ERX_P5      5
#define ERX_P4      4
#define ERX_P3      3
#define ERX_P2      2
#define ERX_P1      1
#define ERX_P0      0
#define AW          0
#define ARD         4
#define ARC         0
#define RF_DR_LOW   5
#define PLL_LOCK    4
#define RF_DR_HIGH  3
#define RF_PWR      1
#define LNA_HCURR   0        
#define RX_DR       6
#define TX_DS       5
#define MAX_RT      4
#define RX_P_NO     1
#define TX_FULL     0
#define PLOS_CNT    4
#define ARC_CNT     0
#define TX_REUSE    6
#define FIFO_FULL   5
#define TX_EMPTY    4
#define RX_FULL     1
#define RX_EMPTY    0
#define DPL_P5      5
#define DPL_P4      4
#define DPL_P3      3
#define DPL_P2      2
#define DPL_P1      1
#define DPL_P0      0
#define EN_DPL      2
#define EN_ACK_PAY  1
#define EN_DYN_ACK  0

// Instruction Mnemonics
#define R_REGISTER    0x00
#define W_REGISTER    0x20
#define REGISTER_MASK 0x1F
#define ACTIVATE      0x50
#define R_RX_PL_WID   0x60
#define R_RX_PAYLOAD  0x61
#define W_TX_PAYLOAD  0xA0
#define FLUSH_TX      0xE1
#define FLUSH_RX      0xE2
#define REUSE_TX_PL   0xE3
#define NOP           0xFF

struct device_attr 
{
    uint8_t CSN;
    uint8_t CE;
    uint8_t USI_DO;
    uint8_t USI_DI;
    uint8_t SCK;
    uint8_t channel;
    uint8_t payload;
    uint8_t base_config;
    uint8_t PTX;
};

static struct device_attr nrf24_device = 
{
    .CSN         = PB4,
    .CE          = PB3,
    .USI_DO      = PB1,
    .USI_DI      = PB0,
    .SCK         = PB2,
    .channel     = 122,
    .payload     = 16,
    .base_config = _BV(EN_CRC) & ~_BV(CRCO),
    .PTX         = 0
};

// 'public' functions
void nrf24_init();
void nrf24_send(uint8_t *value);

// basic spi transmission
static void spi_begin();
static void spi_end();
static uint8_t spi_transfer(uint8_t data);
static void spi_write(uint8_t reg, uint8_t *data, bool read_data, uint8_t len);

// setup 
static void config();
static void set_rx_ADDR(uint8_t * adr);
static void set_tx_ADDR(uint8_t * adr);
static bool data_ready();
static bool is_sending();
//int rxFifoEmpty();
//int txFifoEmpty();
static void get_data(uint8_t * data);
static uint8_t get_status();
static void config_register(uint8_t reg, uint8_t *value);
static void read_register(uint8_t reg, uint8_t *value, uint8_t len);
static void write_register(uint8_t reg, uint8_t *value, uint8_t len);
static void powerup_rx();
static void powerup_tx();
static void power_down();

static void csn_hi();
static void csn_low();
static void ce_hi();
static void ce_low();
static void flush_tx();
static void flush_rx();

#endif // NRF24_H