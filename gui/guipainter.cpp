#include "guipainter.h"

GuiPainter* volatile GuiPainter::p_instance = nullptr;
GuiPainter* GuiPainter::instance()
{
    QMutex mutex;
    mutex.lock();
    if(p_instance == nullptr)
    {
        p_instance = new GuiPainter();
    }
    mutex.unlock();
    return p_instance;
}

QObject* GuiPainter::qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return instance();
}

QString GuiPainter::temperature()
{
    return m_temp;
}

QString GuiPainter::pressure()
{
    return m_press;
}

QString GuiPainter::humidity()
{
    return m_humidity;
}

QString GuiPainter::currentTime()
{
    return m_time;
}

void GuiPainter::UpdateTemperatureLabel()
{
    m_temp = QString::number((LPS25H::instance()->GetTemperature() + HTS221::instance()->GetTemperature()) / 2, 'f', 1);
    emit temperatureChanged();
}

void GuiPainter::UpdateHumidityLabel()
{
    m_humidity = QString::number(HTS221::instance()->GetHumidity(), 'f', 0);
    emit humidityChanged();
}

void GuiPainter::UpdatePressureLabel()
{
    m_press = QString::number(LPS25H::instance()->GetPressure(), 'f', 0);
    emit pressureChanged();
}

void GuiPainter::UpdateTimeLabel()
{
    m_time = QTime::currentTime().toString(QString("hh:mm"));
    emit timeChanged();
}

void GuiPainter::startReadingData()
{
    updateGui(); // first is for free

    // do the same in loop
    QThread* workHorse_sensors = new QThread(this);
    QTimer* timer = new QTimer(0);
    timer->setInterval(1000);
    timer->moveToThread(workHorse_sensors);
    connect(timer, SIGNAL(timeout()), this, SLOT(updateGui()));
    connect(workHorse_sensors, SIGNAL(started()), timer, SLOT(start()));
    workHorse_sensors->start();
}

void GuiPainter::updateGui()
{
    if(LPS25H::instance()->ReadSensor() && HTS221::instance()->ReadSensor())
    {
        UpdateTemperatureLabel();
        UpdateHumidityLabel();
        UpdatePressureLabel();
        UpdateTimeLabel();
    }
}
