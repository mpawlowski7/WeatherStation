/*
 * wireless.c
 *
 * Created: 2016-09-08 11:21:09
 * Author : mipw
 */ 

#define F_CPU	8000000L

#include "spi_device.h"
#include "nrf24.h"

int main(void)
{
    /* Replace with your application code */
	const uint8_t str = "dupa";

	while(1)
	{
		nrf24_send(str);
		PORTB |= _BV(PB4);
		PORTB &= ~_BV(PB3);
		_delay_ms(1000);
		PORTB |= _BV(PB3);
		PORTB &= ~_BV(PB4);
		_delay_ms(1000);
	}
	
	nrf24_power_down();

	return 0;
}

