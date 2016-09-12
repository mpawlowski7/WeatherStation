#include <stdint.h>
#include <stdio.h>

int main()
{
    uint8_t c = 5;
    uint8_t* d = &c;

    printf("Result: %d\n", d[0]);

    return 0;
}