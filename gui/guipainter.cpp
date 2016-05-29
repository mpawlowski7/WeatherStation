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

    engine.load(QUrl(QStringLiteral("qrc:/res/MainView.qml")));

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    QObject *outsideView = window->findChild<QObject *>("outside_view");

    // Connecting signals and slots
    QObject::connect(this, SIGNAL(forecastChanged()), outsideView, SLOT(updateGradientColor()));
}

QObject* GuiPainter::qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return instance();
}

const QString GuiPainter::temperature() const
{
    return QString::number((LPS25H::instance()->GetTemperature() + HTS221::instance()->GetTemperature()) / 2, 'f', 1);
}

const QString GuiPainter::pressure() const
{
    return QString::number(LPS25H::instance()->GetPressure(), 'f', 0);
}

const QString GuiPainter::humidity() const
{
    return QString::number(HTS221::instance()->GetHumidity(), 'f', 0);
}

const QVariantMap& GuiPainter::currentWeather() const
{
    return WUManager::instance()->GetCurrentWeather();
}

const QVariantMap& GuiPainter::forecast() const
{
    return WUManager::instance()->Get10DaysForecast();
}

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
    if(LPS25H::instance()->ReadSensor() && HTS221::instance()->ReadSensor())
    {
        emit insideChanged();
    }
    m_currentDateTime.insert("time", QTime::currentTime().toString(QString("hh:mm")));
    m_currentDateTime.insert("date", QDate::currentDate().toString(QString("dd MMMM yyyy")));
    emit timeChanged();

    emit forecastChanged();
}
