#ifndef LPS25H_H
#define LPS25H_H

// pressure sensor
#include "i2cdevice.h"

#define SLAVE_ADDRESS_P     0x5C
#define LPS25H_STATUS_REG   0x27
#define CTRL1_REG           0x20
#define CTRL2_REG           0x21
#define CTRL3_REG           0x22
#define PRESS_OUT_XL        0x28
#define PRESS_OUT_L         0x29
#define PRESS_OUT_H         0x2A
#define TEMP_OUT_L_P        0x2B
#define TEMP_OUT_H_P        0x2C

class LPS25H : public I2CDevice
{
private:
    enum
    {
        DISABLED = 0,
        ENABLED
    } status;

    uint8_t temp_data[2];
    uint8_t pressure_data[3];

    float_t temp_calc;
    float_t pressure;

    virtual bool Init() const;
    virtual bool Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t reg_count, uint8_t * output) const;
    virtual bool Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const;
    void UpdateTemperature();
    void UpdatePressure();

    // singleton stuff
    static LPS25H * p_instance;
    LPS25H();
    LPS25H(const LPS25H &) {}
    LPS25H& operator=(const LPS25H &) { return *this; }
    virtual ~LPS25H();

public:
    static LPS25H * instance();
    virtual bool ReadSensor();
    float_t GetTemperature() const;
    float_t GetPressure() const;
};

#endif // LPS25H_H
