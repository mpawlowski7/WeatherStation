#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>

#define  DEVICE_ADDR   0x1D
#define  X_AXIS_OUT    0x29
#define  Y_AXIS_OUT    0x2B
#define  Z_AXIS_OUT    0x2D

const uint8_t axises[3] = {X_AXIS_OUT, Y_AXIS_OUT, Z_AXIS_OUT};

int configDevice(int fd, const uint8_t reg, const uint8_t val)
{
 	struct i2c_rdwr_ioctl_data packets;
	struct i2c_msg messages[1];
    uint8_t data[2];

	data[0] = reg;
	data[1] = val;

	messages[0].addr = DEVICE_ADDR;
	messages[0].flags = 0;
	messages[0].len = 2;
	messages[0].buf = data;

	packets.msgs = messages;
	packets.nmsgs = 1;

	if(ioctl(fd, I2C_RDWR, &packets) < 0) {
		perror("Unable to communicate with i2c device");
		return 1;
	}

	return 0;
}

int readDevice(int fd, uint8_t buf[])
{
    struct i2c_rdwr_ioctl_data packets;
    struct i2c_msg messages[2];
    
    for(uint8_t i = 0; i < 3; i++)
    {
       messages[0].addr = DEVICE_ADDR;
	   messages[0].flags = 0;
	   messages[0].len = 2;
	   messages[0].buf = &axises[i];
       
       messages[1].addr = DEVICE_ADDR;
	   messages[1].flags = I2C_M_RD;
	   messages[1].len = 1;
	   messages[1].buf = &buf[i];       
       
       packets.msgs = messages;
       packets.nmsgs = 2;

       if(ioctl(fd, I2C_RDWR, &packets) < 0) {
           perror("readDevice. Unable to communicate with i2c device");
           return 1;
       }
    }

	return 0;
}

int main(int argc, char *argv[])
{
 //  int bus;
   int fd;
 //  uint8_t x, _x, y, _y, z, _z = 0;
   uint8_t buffer[3];  
      
   const char *filename = "/dev/i2c-1";   
 
   if ((fd = open(filename, O_RDWR)) < 0)
   {
      // Open port for reading and writing
      fprintf(stderr, "Failed to open i2c bus %s", filename);
      exit(1);
   }
   
   configDevice(fd, 0x20, 0b01000111);
   
   while (1)
   {   
       if (readDevice(fd, buffer) == 0)
       {
           printf("x: %d\t y: %d\t z: %d\n", buffer[0], buffer[1], buffer[2]);
       }
       usleep(10000);
   }       
      
   return 0;
}
