#include "lps25h.h"

LPS25H::LPS25H() :
    temp_data({0}),
    pressure_data({0}),
    temp_calc(0.0),
    pressure(0.0)
{
    if(Init())
    {
        status = ENABLED;
    }
    else
    {
        status = DISABLED;
    }
}

LPS25H::~LPS25H()
{

}

LPS25H * LPS25H::p_instance = nullptr;

LPS25H * LPS25H::instance()
{
    if(p_instance == nullptr)
    {
        p_instance = new LPS25H();
    }
    return p_instance;
}

bool LPS25H::Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t reg_count, uint8_t *output) const
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
        reg_addr += 1; // move to next axis register
    }
    return true;
}

bool LPS25H::Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const
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

bool LPS25H::Init() const
{
    usleep(10);
    return Write(SLAVE_ADDRESS_P, CTRL1_REG, 0x90); // ODR 1Hz, Block Data Update ON
}

bool LPS25H::ReadSensor()
{
//    qDebug() << "Reading LPS25H";
    uint8_t uRes = 0;
    bool bRes = false;
    if(status == ENABLED && !Read(SLAVE_ADDRESS_P, LPS25H_STATUS_REG, 1, &uRes))
    {
        std::cout << "Couldn't read status reg\n";
        return false;
    }
    if(uRes & 2)
    {
        bRes |= Read(SLAVE_ADDRESS_P, PRESS_OUT_XL, 3, pressure_data);
        UpdatePressure();
    }
    if(uRes & 1)
    {
        bRes |= Read(SLAVE_ADDRESS_P, TEMP_OUT_L_P, 2, temp_data);
        UpdateTemperature();
    }
    return bRes;
}

void LPS25H::UpdateTemperature()
{
    temp_calc = 42.5 + int16_t(temp_data[1] << 8 | temp_data[0]) / 480.0;
}

void LPS25H::UpdatePressure()
{
    pressure = float_t(uint32_t(pressure_data[2]) << 16 | (uint16_t(pressure_data[1]) << 8) | pressure_data[0]) / 4096;
}

float_t LPS25H::GetTemperature() const
{
    return temp_calc;
}

float_t LPS25H::GetPressure() const
{
    return pressure;
}
