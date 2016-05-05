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

void GuiPainter::Init(QQmlApplicationEngine & engine)
{
    qmlRegisterSingletonType<GuiPainter>("weatherstation.gui", 1, 0, "GuiPainter", &qmlinstance);
    qmlRegisterSingletonType<LedPainter>("weatherstation.led", 1, 0, "LedPainter", &LedPainter::qmlinstance);

    WUManager::instance()->Init();

    startReadingData();

    engine.load(QUrl(QStringLiteral("qrc:/res/main.qml")));

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    QObject::connect(this, SIGNAL(labelsChanged()), window, SLOT(updateGradientColor()));
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

QString GuiPainter::temperatureOut()
{
    return m_tempOut;

}

QString GuiPainter::feelslikeOut()
{
    return m_feelslikeOut;
}

qreal GuiPainter::windDirOut()
{
    return m_windDirOut;
}

QString GuiPainter::windSpeedOut()
{
    return m_windSpeedOut;
}

QString GuiPainter::humidityOut()
{
    return m_humidityOut;
}

QString GuiPainter::conditionOut()
{
    return m_conditionOut;
}

QString GuiPainter::conditionIcon()
{
    return m_conditionIcon;
}

QString GuiPainter::currentTime()
{
    return m_time;
}

void GuiPainter::startReadingData()
{
    qDebug() << "Start reading data";
    updateGui(); // first is for free

    // do the same in loop
    QThread* workHorse = new QThread(this);
    QTimer* timer = new QTimer(0);

    timer->setInterval(1000);
    timer->moveToThread(workHorse);
    connect(timer, SIGNAL(timeout()), this, SLOT(updateGui()));
    connect(workHorse, SIGNAL(started()), timer, SLOT(start()));
    workHorse->start();
}

void GuiPainter::updateGui()
{
    if(LPS25H::instance()->ReadSensor() && HTS221::instance()->ReadSensor())
    {
        m_temp = QString::number((LPS25H::instance()->GetTemperature() + HTS221::instance()->GetTemperature()) / 2, 'f', 1);
        m_humidity = QString::number(HTS221::instance()->GetHumidity(), 'f', 0);
        m_press = QString::number(LPS25H::instance()->GetPressure(), 'f', 0);        
    }

    m_time = QTime::currentTime().toString(QString("hh:mm"));

    m_tempOut = QString::number(WUManager::instance()->GetCurrentWeather().temp_c, 'f', 1);
    m_feelslikeOut = WUManager::instance()->GetCurrentWeather().feelslike_c;
    m_humidityOut = WUManager::instance()->GetCurrentWeather().relative_humidity;
    m_windDirOut = WUManager::instance()->GetCurrentWeather().wind_dir;
    m_windSpeedOut = QString::number(WUManager::instance()->GetCurrentWeather().wind_kph, 'f', 1);
    m_conditionOut = WUManager::instance()->GetCurrentWeather().condition;
    m_conditionIcon = WUManager::instance()->GetCurrentWeather().icon;

    emit labelsChanged();
}
