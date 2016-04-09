#include "hts221.h"

#include <iostream>

HTS221::HTS221()
{
    Init();
}

HTS221::~HTS221()
{

}

HTS221 * HTS221::p_instance = nullptr;

HTS221 * HTS221::instance()
{
    if(p_instance == nullptr)
    {
        p_instance = new HTS221();
    }
    return p_instance;
}

bool HTS221::Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t byte_count, uint8_t *output) const
{
    struct i2c_msg msg[2];

    for (int i=0; i<byte_count; i++)
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
        reg_addr += 1; // move to next axis register
    }
    return true;
}

bool HTS221::Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const
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

bool HTS221::Init() const
{
    HTS221 * t = const_cast<HTS221*>(this);
    usleep(10);
    return Write(SLAVE_ADDRESS_H, CTRL1_REG, 0x87) && t->ReadCalibrationData();
}

bool HTS221::ReadSensor()
{
 //   qDebug() << "Reading HTS221";
    uint8_t status = 0;
    bool bRes = false;
    if(!Read(SLAVE_ADDRESS_H, HTS221_STATUS_REG, 1, &status))
    {
        std::cout << "Couldn't read status reg\n";
        return false;
    }
    if(status & 2)
    {
        bRes |= Read(SLAVE_ADDRESS_H, HUMIDITY_OUT_L, 2, humidity_data);
        UpdateHumidity();
    }
    if(status & 1)
    {
        bRes |= Read(SLAVE_ADDRESS_H, TEMP_OUT_L_H, 2, temp_data);
        UpdateTemperature();
    }
    return bRes;
}

void HTS221::UpdateTemperature()
{
    convert T_OUT;
    T_OUT.raw[0] = temp_data[0];
    T_OUT.raw[1] = temp_data[1];
    float_t T0_degC = (uint16_t(T0_degC_x8) | (uint16_t(T1_T0msb & 0x03) << 8)) / 8.0;
    float_t T1_degC = (uint16_t(T1_degC_x8) | (uint16_t(T1_T0msb & 0x0C) << 6)) / 8.0;
    temperature = (T0_degC + (T_OUT.out - T0_OUT) * (T1_degC - T0_degC) / (T1_OUT - T0_OUT));
}

void HTS221::UpdateHumidity()
{
    convert H_OUT;
    H_OUT.raw[0] = temp_data[0];
    H_OUT.raw[1] = humidity_data[1];
    float_t H0_rH = H0_rH_x2 / 2.0;
    float_t H1_rH = H1_rH_x2 / 2.0;
    humidity = (H0_rH + (H_OUT.out - H0_OUT) * (H1_rH - H0_rH) / (H1_OUT - H0_OUT));

}

bool HTS221::ReadCalibrationData()
{
//    convert _t0_out, _t1_out, _h0_out, _h1_out;
    bool bRes =
    Read(SLAVE_ADDRESS_H, H0_RH_X2_, 1, &H0_rH_x2) &&
    Read(SLAVE_ADDRESS_H, H1_RH_X2_, 1, &H1_rH_x2) &&
    Read(SLAVE_ADDRESS_H, T0_DEGC_X8_, 1, &T0_degC_x8) &&
    Read(SLAVE_ADDRESS_H, T1_DEGC_X8_, 1, &T1_degC_x8) &&
    Read(SLAVE_ADDRESS_H, T1_T0_MSB_, 1, &T1_T0msb) &&
    Read(SLAVE_ADDRESS_H, H0_T0_OUT_L, 2, _h0_out.raw) &&
    Read(SLAVE_ADDRESS_H, H1_T0_OUT_L, 2, _h1_out.raw) &&
    Read(SLAVE_ADDRESS_H, T0_OUT_L, 2, _t0_out.raw) &&
    Read(SLAVE_ADDRESS_H, T1_OUT_L, 2, _t1_out.raw);
    T0_OUT = _t0_out.out;
    T1_OUT = _t1_out.out;
    H0_OUT = _h0_out.out;
    H1_OUT = _h1_out.out;
    return bRes;
}

float_t HTS221::GetTemperature() const
{
    return temperature;
}

float_t HTS221::GetHumidity() const
{
    return humidity;
}
