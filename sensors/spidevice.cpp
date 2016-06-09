#include "spidevice.h"

int SPIDevice::fd = 0;

SPIDevice::SPIDevice()
{
    if (fd == 0 && (fd = open(spi_file, O_RDWR)) < 0)
    {
       // Open port for reading and writing
       fprintf(stderr, "Failed to open i2c bus %s", spi_file);
       exit(1);
    }
}

SPIDevice::~SPIDevice()
{

}

int SPIDevice::Send(i2c_msg * msg, int msg_count) const
{
   struct i2c_rdwr_ioctl_data packets;

   packets.msgs = msg;
   packets.nmsgs = msg_count;

   return ioctl(fd, I2C_RDWR, &packets);
}
