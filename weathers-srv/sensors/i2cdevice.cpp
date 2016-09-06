#include "i2cdevice.h"

int I2CDevice::fd = 0;

I2CDevice::I2CDevice()
{
    if (fd == 0 && (fd = open(i2c_file, O_RDWR)) < 0)
    {
       // Open port for reading and writing
       fprintf(stderr, "Failed to open i2c bus %s", i2c_file);
       exit(1);
    }
}

I2CDevice::~I2CDevice()
{

}

int I2CDevice::Send(i2c_msg * msg, int msg_count) const
{
   struct i2c_rdwr_ioctl_data packets;

   packets.msgs = msg;
   packets.nmsgs = msg_count;

   return ioctl(fd, I2C_RDWR, &packets);
}
