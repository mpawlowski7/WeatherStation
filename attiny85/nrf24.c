#include "nrf24.h"
#include "spi_device.h"


struct nrf24_info 
{
    uint8_t channel;
    uint8_t payload;
    uint8_t base_config;
    enum MODE
    {
        _PTX = 0,
        _PRX = 1
    } mode;
};

static struct nrf24_info nrf24 = 
{
    .channel     = 122,
    .payload     = 4,
    .base_config = _BV(EN_CRC) & ~_BV(CRCO),
    .mode        = _PTX
};

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

static inline void ce_hi()
{
   PORTB |= _BV(_CE);
}

static inline void ce_low()
{
   PORTB &= ~_BV(_CE);
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
    DDRB |=  (_BV(_CSN) | _BV(_CE));

    ce_low();
    spi_begin();
    config();   
 }

void nrf24_send(uint8_t *data)
 {
     uint8_t status;
     while(nrf24.mode == _PTX)
     {
         status = get_status();
         if((status & (_BV(TX_DS) | _BV(MAX_RT))))
         {
             nrf24.mode = _PRX;
             break;
         }
     }
     ce_low();

     powerup_tx();
     flush_tx();

     spi_write(W_TX_PAYLOAD, data, false, nrf24.payload);
 }

static void config()
{
    config_register(RF_CH, &nrf24.channel);
    // set payload lenght
    config_register(RX_PW_P0, &nrf24.payload);
    config_register(RX_PW_P1, &nrf24.payload);
}

static void set_rx_ADDR(uint8_t * address)
{
    ce_low();
    write_register(RX_ADDR_P1, address, NRF_ADDR_LEN);
    ce_hi();
}

static void set_tx_ADDR(uint8_t * address)
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