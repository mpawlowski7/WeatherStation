#ifndef I2CDEVICE_H
#define I2CDEVICE_H

#include <stdint.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

#include <iostream>

class I2CDevice
{
private:
    static int fd;
    const char *i2c_file = "/dev/i2c-1";

    virtual bool Init() const = 0;
    virtual bool Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t reg_count, uint8_t * output) const = 0;
    virtual bool Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const = 0;

public:
    I2CDevice();
    virtual ~I2CDevice();
    virtual bool ReadSensor() = 0;
    int Send(i2c_msg * msg, int msg_count) const;
};

#endif // I2CDEVICE_H
