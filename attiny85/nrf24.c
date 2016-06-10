#include "nrf24.h"

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
    .payload     = 4,
    .base_config = _BV(EN_CRC) & ~_BV(CRCO),
    .PTX         = 0
};

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
static bool rx_fifo_empty();
static bool tx_fifo_empty();
static void get_data(uint8_t * data);
static uint8_t get_status();
static void config_register(uint8_t reg, uint8_t *value);
static void read_register(uint8_t reg, uint8_t *value, uint8_t len);
static void write_register(uint8_t reg, uint8_t *value, uint8_t len);
static void powerup_rx();
static void powerup_tx();
static void power_down();

static inline void csn_hi()
{
   PORTB |= _BV(nrf24_device.CSN);
}

static inline void csn_low()
{
   PORTB &= ~_BV(nrf24_device.CSN);
}

static inline void ce_hi()
{
   PORTB |= _BV(nrf24_device.CE);
}

static inline void ce_low()
{
   PORTB &= ~_BV(nrf24_device.CE);
}

static inline void flush_tx()
{
   spi_write(FLUSH_TX, 0, 0, 0);
}

static inline void flush_rx()
{
   spi_write(FLUSH_RX, 0, 0, 0);
}

void nrf24_init()
 {    
    DDRB |=  (_BV(nrf24_device.CSN) | _BV(nrf24_device.CE));

    ce_low();
    csn_hi();

    spi_begin();
    config();   
 }

void nrf24_send(uint8_t *data)
 {
     uint8_t status;
     while(nrf24_device.PTX)
     {
         status = get_status();
         if((status & (_BV(TX_DS) | _BV(MAX_RT))))
         {
             nrf24_device.PTX = 0;
             break;
         }
     }
     ce_low();

     powerup_tx();
     flush_tx();

     spi_write(W_TX_PAYLOAD, data, false, nrf24_device.payload);
 }

static void spi_begin()
{
    DDRB &= ~(_BV(nrf24_device.SCK) | _BV(nrf24_device.USI_DO));
    DDRB |= _BV(nrf24_device.USI_DI);

    PORTB &= ~(_BV(nrf24_device.SCK) | _BV(nrf24_device.USI_DO));
    PORTB |= _BV(nrf24_device.USI_DI);
}

static void spi_end()
{
    DDRB = _BV(nrf24_device.SCK) | _BV(nrf24_device.USI_DO) | _BV(nrf24_device.USI_DI);
}

static uint8_t spi_transfer(uint8_t _data)
{
    USIDR = _data;
    USISR = _BV(USIOIF);

    while((USISR & _BV(USIOIF)) == 0)
    {
        USICR = _BV(USIWM0) | _BV(USICS1) | _BV(USICLK) | _BV(USITC);
    }

    return USIDR;
}

static void config()
{
    config_register(RF_CH, nrf24_device.channel);

    // set payload lenght
    config_register(RF_CH, nrf24_device.channel);
    config_register(RF_CH, nrf24_device.channel);
}

static void set_rx_ADDR(uint8_t * adr)
{

}

static void set_tx_ADDR(uint8_t * adr)
{

}

static bool data_ready()
{
    return true;
}

static bool is_sending()
{

    return true;
}


static void get_data(uint8_t * data)
{

}

static uint8_t get_status()
{
    uint8_t res = NOP;
    read_register(STATUS, &res, 1);
    return res;
}

static void config_register(uint8_t reg, uint8_t *value)
{
    write_register(reg, value, 1);
}

static void read_register(uint8_t reg, uint8_t *value, uint8_t len)
{

}

static void write_register(uint8_t reg, uint8_t *value, uint8_t len)
{
    spi_write((W_REGISTER | (REGISTER_MASK & reg)), value, true, len);
}

static void powerup_rx()
{

}

static void powerup_tx()
{

}

static void power_down()
{

}

static void spi_write(uint8_t reg, uint8_t *data, bool read_data, uint8_t len)
{
   csn_low();
   spi_transfer(reg);
   if (data) 
   {
      uint8_t i;
      for(i = 0; i < len; ++i) 
      {
         uint8_t read_value = spi_transfer(data[i]);
         if (read_data == 1) 
         {
            data[i] = read_value;
         }
      }
   }
   csn_hi();
}