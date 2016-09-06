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

void GuiPainter::init(QQmlApplicationEngine & engine)
{
    qmlRegisterSingletonType<GuiPainter>("weatherstation.gui", 1, 0, "GuiPainter", &qmlinstance);

  // connect to server  WUManager::instance()->Init();

    startReadingData();

    engine.load(QUrl(QStringLiteral("qrc:/res/MainView.qml")));

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    QObject *outsideView = window->findChild<QObject *>("outside_view");
    QObject *forecastView = window->findChild<QObject *>("forecast_view");
    QObject *insideView = window->findChild<QObject *>("inside_view");

    // Connecting signals and slots
    QObject::connect(this, SIGNAL(forecastChanged()), outsideView, SLOT(updateGradientColor()));
    QObject::connect(this, SIGNAL(forecastChanged()), forecastView, SLOT(updateData()));
    QObject::connect(this, SIGNAL(insideChanged()), insideView, SLOT(updateData()));
}

QObject* GuiPainter::qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return instance();
}

//const QString GuiPainter::temperature() const
//{
//    return 0;//QString::number((LPS25H::instance()->GetTemperature() + HTS221::instance()->GetTemperature()) / 2, 'f', 1);
//}

//const QString GuiPainter::pressure() const
//{
//    return 0;//QString::number(LPS25H::instance()->GetPressure(), 'f', 0);
//}

//const QString GuiPainter::humidity() const
//{
//    return 0//QString::number(HTS221::instance()->GetHumidity(), 'f', 0);
//}

//const QVariantMap& GuiPainter::currentWeather() const
//{
//    return 0; // WUManager::instance()->GetCurrentWeather();
//}

//const QVariantMap& GuiPainter::forecast() const
//{
//    return 0; // WUManager::instance()->Get10DaysForecast();
//}

const QVariantMap& GuiPainter::currentDateTime() const
{
    return m_currentDateTime;
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
//    if(LPS25H::instance()->ReadSensor() && HTS221::instance()->ReadSensor())
//    {
        emit insideChanged();
//    }

    m_currentDateTime.insert("time", QTime::currentTime().toString(QString("hh:mm")));
    m_currentDateTime.insert("date", QDate::currentDate().toString(QString("dd.MM.yyyy")));

    emit timeChanged();
    emit forecastChanged();
}
