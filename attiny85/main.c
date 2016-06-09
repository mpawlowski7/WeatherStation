#define F_CPU 1000000L

#include <avr/io.h>
#include <util/delay.h>

#include "nrf24.h"

int main(void)
{
    // setting USB pins as output
    DDRB |=  (_BV(PB4) | _BV(PB3));

    nrf24_init();
    uint8_t* str = (uint8_t*)"dupa";   

    while(1)
    {
    //    nrf24_send(str);
        PORTB |= _BV(PB4);
        PORTB &= ~_BV(PB3);
        _delay_ms(1000);
        PORTB |= _BV(PB3);
        PORTB &= ~_BV(PB4);
        _delay_ms(1000);
    }

    return 0;
}