#include "lsm9ds1.h"

LSM9DS1::LSM9DS1()
{
     Init();
}

LSM9DS1::~LSM9DS1()
{

}

LSM9DS1 * LSM9DS1::p_instance = nullptr;

LSM9DS1 * LSM9DS1::instance()
{
    if(p_instance == nullptr)
    {
        p_instance = new LSM9DS1();
    }
    return p_instance;
}

bool LSM9DS1::Init() const
{
    usleep(10);
    return Write(SLAVE_ADDRESS_G, CTRL_REG1_G, 0x69) && Write(SLAVE_ADDRESS_G, CTRL_REG6_XL, 0x7B) && Write(SLAVE_ADDRESS_M, CTRL_REG1_M, 0x14);
}

bool LSM9DS1::Write(uint16_t slave_addr, uint8_t reg_addr, uint8_t value) const
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

bool LSM9DS1::Read(uint16_t slave_addr, uint8_t reg_addr, uint8_t reg_count, uint8_t * output) const
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

bool LSM9DS1::ReadSensor()
{
 //   qDebug() << "Reading LSM91DS1";
    uint8_t m_status =0;
    uint8_t g_status = 0;
    bool mRes = false;
    bool gRes = false;
    if(!Read(SLAVE_ADDRESS_G, LSM9DS1_STATUS_REG, 1, &g_status))
    {
        std::cout << "Couldn't read gyro, acc and temp status reg.\n";
        return false;
    }
    if(!Read(SLAVE_ADDRESS_M, LSM9DS1_STATUS_REG, 1, &m_status))
    {
        std::cout << "Couldn't read mag status reg.\n";
        return false;
    }

    if(g_status & 4)
    {
        gRes |= Read(SLAVE_ADDRESS_G, OUT_TEMP_L, 6, temp_data);
        UpdateTemperature();
    }
    if(g_status & 2)    {

        gRes |= Read(SLAVE_ADDRESS_G, OUT_X_G_L, 6, gyro_data);
        UpdateGyroVector();
    }
    if(g_status & 1)
    {
        gRes |= Read(SLAVE_ADDRESS_G, OUT_X_A_L, 6, acc_data);
        UpdateAccVector();
    }
    if(m_status & 8)
    {
        mRes |= Read(SLAVE_ADDRESS_M, OUT_X_M_L, 6, mag_data);
        UpdateMagVector();
    }
    return mRes || gRes;
}

void LSM9DS1::UpdateAccVector()
{
    convert acc_x, acc_y, acc_z;

    acc_x.raw[0] = acc_data[0];
    acc_x.raw[1] = acc_data[1];
    acc_y.raw[0] = acc_data[2];
    acc_y.raw[1] = acc_data[3];
    acc_z.raw[0] = acc_data[4];
    acc_z.raw[1] = acc_data[5];

    int16_t acc_x_s = static_cast<int16_t>(acc_x.out);
    int16_t acc_y_s = static_cast<int16_t>(acc_y.out);
    int16_t acc_z_s = static_cast<int16_t>(acc_z.out);

    acc_vector.setX(acc_x_s*0.244*0.001);     // datasheet p.12 acc characteristics for 8g
    acc_vector.setY(acc_y_s*0.244*0.001);
    acc_vector.setZ(acc_z_s*0.244*0.001);
}

void LSM9DS1::UpdateGyroVector()
{
    convert gyro_x, gyro_y, gyro_z;

    gyro_x.raw[0] = gyro_data[0];
    gyro_x.raw[1] = gyro_data[1];
    gyro_y.raw[0] = gyro_data[2];
    gyro_y.raw[1] = gyro_data[3];
    gyro_z.raw[0] = gyro_data[4];
    gyro_z.raw[1] = gyro_data[5];

    int16_t gyro_x_s = static_cast<int16_t>(gyro_x.out);
    int16_t gyro_y_s = static_cast<int16_t>(gyro_y.out);
    int16_t gyro_z_s = static_cast<int16_t>(gyro_z.out);

    gyro_vector.setX(gyro_x_s*17.50*0.001*DEG_TO_RAD); // datasheet p.12 gyro characteristics for 500dps
    gyro_vector.setY(gyro_y_s*17.50*0.001*DEG_TO_RAD);
    gyro_vector.setZ(gyro_z_s*17.50*0.001*DEG_TO_RAD);
}

void LSM9DS1::UpdateMagVector()
{
    convert mag_x, mag_y, mag_z;

    mag_x.raw[0] = mag_data[0];
    mag_x.raw[1] = mag_data[1];
    mag_y.raw[0] = mag_data[2];
    mag_y.raw[1] = mag_data[3];
    mag_z.raw[0] = mag_data[4];
    mag_z.raw[1] = mag_data[5];

    int16_t mag_x_s = static_cast<int16_t>(mag_x.out);
    int16_t mag_y_s = static_cast<int16_t>(mag_y.out);
    int16_t mag_z_s = static_cast<int16_t>(mag_z.out);

    mag_vector.setX(mag_x_s*0.14*mGS_TO_uT);    // datasheet p.12 mag for 4Gs
    mag_vector.setY(mag_y_s*0.14*mGS_TO_uT);
    mag_vector.setZ(mag_z_s*0.14*mGS_TO_uT);
}

void LSM9DS1::UpdateTemperature()
{
    convert temp;
    temp.raw[0] = temp_data[0];
    temp.raw[1] = temp_data[1];
    temperature = 25 + int16_t(temp.out << 4)/2048.0;
}

QVector3D LSM9DS1::GetAccVector() const
{
    return acc_vector;
}

QVector3D LSM9DS1::GetGyroVector() const
{
    return gyro_vector;
}

QVector3D LSM9DS1::GetMagVector() const
{
    return mag_vector;
}

float_t LSM9DS1::GetTemperature() const
{
    return temperature;
}
