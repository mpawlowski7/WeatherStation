#ifndef HTS221_H
#define HTS221_H

// humidity sensor
#include "i2cdevice.h"

#define SLAVE_ADDRESS_H      0x5F
#define HTS221_STATUS_REG    0x27

#define CTRL1_REG            0x20
#define CTRL2_REG            0x21
#define CTRL3_REG            0x22
#define HUMIDITY_OUT_L       0x28
#define HUMIDITY_OUT_H       0x29
#define TEMP_OUT_L_H         0x2A
#define TEMP_OUT_H_H         0x2B

// Calibration data
#define H0_RH_X2_            0x30
#define H1_RH_X2_            0x31
#define T0_DEGC_X8_          0x32
#define T1_DEGC_X8_          0x33
#define T1_T0_MSB_           0x35

#define H0_T0_OUT_L          0x36
#define H0_T0_OUT_H          0x37
#define H1_T0_OUT_L          0x3A
#define H1_T0_OUT_H          0x3B

#define T0_OUT_L             0x3C
#define T0_OUT_H             0x3D
#define T1_OUT_L             0x3E
#define T1_OUT_H             0x3F

class HTS221 : public I2CDevice
{
private:
    union convert
    {
        int16_t out;
        uint8_t  raw[2];
    } _t0_out, _t1_out, _h0_out, _h1_out;

    uint8_t temp_data[2];
    uint8_t humidity_data[2];

    uint8_t T0_degC_x8;
    uint8_t T1_degC_x8;
    uint8_t H0_rH_x2;
    uint8_t H1_rH_x2;

    int16_t T0_OUT;
    int16_t T1_OUT;
    int16_t H0_OUT;
    int16_t H1_OUT;

    uint8_t T1_T0msb;

    float_t temperature;
    float_t humidity;

    virtual bool Init() const;
    virtual bool Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t reg_count, uint8_t * output) const;
    virtual bool Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const;

    // singleton stuff
    static HTS221 * p_instance;
    HTS221();
    HTS221(const HTS221 &) {}
    HTS221& operator=(const HTS221&) { return *this; }
    virtual ~HTS221();

public:
    static HTS221 * instance();
    virtual bool ReadSensor();
    float_t GetTemperature() const;
    float_t GetHumidity() const;
    void UpdateTemperature();
    void UpdateHumidity();
    bool ReadCalibrationData();
};

#endif // HTS221_H
