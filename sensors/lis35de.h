#ifndef LIS35DE_H
#define LIS35DE_H

#include "i2cdevice.h"
#include <QVector3D>
#include <QObject>

#define SLAVE_ADDRESS_A    0x1D
#define CTRL1_REG          0x20
#define CTRL2_REG          0x21
#define CTRL3_REG          0x22
#define OUT_X_A            0x29
#define OUT_Y_A            0x2B
#define OUT_Z_A            0x2D

class LIS35DE : public I2CDevice
{
private:
    uint8_t acc_data[3];
    QVector3D acc_vector;

    virtual bool Init() const;
    virtual bool Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t reg_count, uint8_t * output) const;
    virtual bool Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const;

    void UpdateAccVector();

    // singleton stuff
    static LIS35DE * p_instance;
    LIS35DE();
    LIS35DE(const LIS35DE &) {}
    LIS35DE& operator=(const LIS35DE&) { return *this; }
    virtual ~LIS35DE();

public:
    static LIS35DE * instance();
    virtual bool ReadSensor();
    QVector3D GetAccVector() const;
    QVector3D GetAccVectorRaw() const;
};

#endif // LIS35DE_H
