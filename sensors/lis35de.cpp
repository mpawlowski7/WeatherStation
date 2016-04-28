#include <iostream>
#include "lis35de.h"

LIS35DE::LIS35DE() : I2CDevice()
{
    Init();
}

LIS35DE::~LIS35DE()
{
}

LIS35DE * LIS35DE::p_instance = nullptr;

LIS35DE * LIS35DE::instance()
{
    if(p_instance == nullptr)
    {
        p_instance = new LIS35DE();
    }
    return p_instance;
}

bool LIS35DE::Init() const
{
    return Write(SLAVE_ADDRESS_A, CTRL1_REG, 0b01000111);
}

bool LIS35DE::Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const
{
    struct i2c_msg msg[1];
    uint8_t data[2];

    data[0] = reg_addr;
    data[1] = value;

    msg[0].addr  = slave_addr;
    msg[0].flags = 0;
    msg[0].len   = 2;
    msg[0].buf   = data;

    if(I2CDevice::Send(msg, 1) < 0)
    {
        perror("[I2C Write]:Unable to communicate with i2c device");
        return false;
    }
    return true;
}

bool LIS35DE::Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t reg_count, uint8_t * output) const
{
    struct i2c_msg msg[2];

    for (int i=0; i<reg_count; i++)
    {
        msg[0].addr = slave_addr;
        msg[0].flags = 0;
        msg[0].len = 1;
        msg[0].buf = &reg_addr;

        msg[1].addr = slave_addr;
        msg[1].flags = I2C_M_RD;
        msg[1].len = 1;
        msg[1].buf = &output[i];

        if(I2CDevice::Send(msg, 2) < 0) {
            perror("[I2C Read]:Unable to communicate with i2c device");
            return false;
        }
        reg_addr += 2; // move to next axis register
    }
    return true;
}

bool LIS35DE::ReadSensor()
{
    bool bRes = Read(SLAVE_ADDRESS_A, OUT_X_A, 3, acc_data);
    if(bRes)
    {
        UpdateAccVector();
    }
    return bRes;
}

void LIS35DE::UpdateAccVector()
{
    int8_t acc_x_s = static_cast<int8_t>(acc_data[0]);
    int8_t acc_y_s = static_cast<int8_t>(acc_data[1]);
    int8_t acc_z_s = static_cast<int8_t>(acc_data[2]);

    acc_vector.setX(static_cast<float_t>(acc_x_s)*2.0/128.0);
    acc_vector.setY(static_cast<float_t>(acc_y_s)*2.0/128.0);
    acc_vector.setZ(static_cast<float_t>(acc_z_s)*2.0/128.0);
}

QVector3D LIS35DE::GetAccVector() const
{
    return acc_vector;
}

QVector3D LIS35DE::GetAccVectorRaw() const
{
    return QVector3D(acc_data[0], acc_data[1], acc_data[2]);
}
