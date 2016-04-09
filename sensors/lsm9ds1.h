#ifndef LSM9DS1_H
#define LSM9DS1_H

#include "i2cdevice.h"
#include <QVector3D>

// Device addresses
#define SLAVE_ADDRESS_G         0x6a
#define SLAVE_ADDRESS_M         0x1c

// Status registers
#define LSM9DS1_STATUS_REG      0x27

// Setup ACC & GYRO
#define WHO_AM_I                0x0F
#define CTRL_REG1_G             0x10
#define CTRL_REG2_G             0x11
#define CTRL_REG3_G             0x12
#define CTRL_REG5_XL            0x1F
#define CTRL_REG6_XL            0x20
#define OFFSET_X_L              0x05
#define OFFSET_Y_L              0x07

// Setup MAG
#define MAG_OFFSET_Z            0x09
#define MAG_WHO_AM_I            0x0F
#define CTRL_REG1_M             0x20
#define CTRL_REG2_M             0x21
#define CTRL_REG3_M             0x22
#define CTRL_REG4_M             0x23
#define CTRL_REG5_M             0x24

// Temp output
#define OUT_TEMP_L              0x15
#define OUT_TEMP_H              0x16

// Gyro output
#define OUT_X_G_L               0x18
#define OUT_X_G_H               0x19
#define OUT_Y_G_L               0x1A
#define OUT_Y_G_H               0x1B
#define OUT_Z_G_L               0x1C
#define OUT_Z_G_H               0x1D

// Magnetometer output
#define OUT_X_M_L               0x28
#define OUT_X_M_H               0x29
#define OUT_Y_M_L               0x2A
#define OUT_Y_M_H               0x2B
#define OUT_Z_M_L               0x2C
#define OUT_Z_M_H               0x2D

// Accelerometer output
#define OUT_X_A_L               0x28
#define OUT_X_A_H               0x29
#define OUT_Y_A_L               0x2A
#define OUT_Y_A_H               0x2B
#define OUT_Z_A_L               0x2C
#define OUT_Z_A_H               0x2D


#define PI                      3.1415926535    // degrees per seconds to radians per seconds
#define DEG_TO_RAD              (PI/180.0)
#define RAD_TO_DEG              (180.0/PI)
#define mGS_TO_uT               0.1             // Gauss to micro tesla

class LSM9DS1 : public I2CDevice
{
private:
    union convert
    {
        uint16_t out;
        uint8_t  raw[2];
    };

    uint8_t acc_data [6];
    uint8_t gyro_data[6];
    uint8_t mag_data [6];
    uint8_t temp_data[2];

    QVector3D acc_vector;
    QVector3D gyro_vector;
    QVector3D mag_vector;

    float_t temperature;

    virtual bool Init() const;
    virtual bool Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t reg_count, uint8_t * output) const;
    virtual bool Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const;
    void UpdateAccVector();
    void UpdateGyroVector();
    void UpdateMagVector();
    void UpdateTemperature();

    float_t GetTemperature() const;

    // singleton stuff
    static LSM9DS1 * p_instance;
    LSM9DS1();
    LSM9DS1(const LSM9DS1 &) {}
    LSM9DS1& operator=(const LSM9DS1 &) { return *this; }
    virtual ~LSM9DS1();

public:
    static LSM9DS1 * instance();
    virtual bool ReadSensor();
    QVector3D GetAccVector() const;
    QVector3D GetGyroVector() const;
    QVector3D GetMagVector() const;

};

#endif // LSM9DS1_H
