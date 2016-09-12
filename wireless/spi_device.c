#include "spi_device.h"

enum MODE 
{
    read = 0,
    write = 1,
    rw
} mode;

void spi_init()
{
    DDRB |= (_BV(_SCK) | _BV(_USI_DO)) | _BV(_USI_DI);

    PORTB &= ~(_BV(_SCK) | _BV(_USI_DO));
    PORTB |= _BV(_USI_DI);

    USICR |= _BV(USIWM0) | _BV(USICS1) | _BV(USICLK);
}

// void spi_end()
// {
//     DDRB = _BV(_SCK) | _BV(_USI_DO) | _BV(_USI_DI);
// }

uint8_t spi_transfer(uint8_t _data)
{
    USIDR = _data;
    USISR |= _BV(USIOIF);

    while((USISR & _BV(USIOIF)) == 0)
    {
        USICR |= _BV(USITC);
    }

    return USIDR;
}

void spi_rw(uint8_t reg, uint8_t* data, enum MODE mode, uint8_t len)
{
   csn_low();
   _delay_us(10);
   spi_transfer(reg);
   _delay_us(10);
   if (data) 
   {
      uint8_t i;
      for(i = 0; i < len; ++i) 
      {
         uint8_t read_value = spi_transfer(data[i]);
         //if (read_data) 
         //{
            //data[i] = read_value;
         //}
      }
   }
   csn_hi();
}

void csn_hi()
{
   PORTB |= _BV(_CSN);
}

void csn_low()
{
   PORTB &= ~_BV(_CSN);
}