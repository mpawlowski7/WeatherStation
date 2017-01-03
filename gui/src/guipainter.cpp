#include "guipainter.h"

GuiPainter::GuiPainter(QObject* parent) : QObject(parent), p_tcpSocket(new QTcpSocket(this)) {
    m_currentWeather.insert("location", "-.-");
    m_currentWeather.insert("weather", "-.-");
    m_currentWeather.insert("temp_c", "-.-");
    m_currentWeather.insert("feelslike_c", "-.-");
    m_currentWeather.insert("relative_humidity", "-.-");
    m_currentWeather.insert("wind_degrees", "-.-");
    m_currentWeather.insert("wind_kph", "-.-");
    m_currentWeather.insert("icon", "-.-");

    m_forecast.insert("date", QVariantList());
    m_forecast.insert("temp_high", QVariantList());
    m_forecast.insert("temp_low", QVariantList());
    m_forecast.insert("conditions", QVariantList());
    m_forecast.insert("icon", QVariantList());

    m_temperature = "-.-";
    m_pressure = "-.-";
    m_humidity = "-.-";
}

GuiPainter* volatile GuiPainter::p_instance = nullptr;
GuiPainter* GuiPainter::instance() {
    QMutex mutex;
    mutex.lock();
    if(p_instance == nullptr)
    {
        p_instance = new GuiPainter();
    }
    mutex.unlock();
    return p_instance;
}

void GuiPainter::init(QGuiApplication& app) {
    screen = app.primaryScreen();

    qDebug() << "Physical dots per inch: " << screen->physicalDotsPerInch();
    qDebug() << "Logical dots per inch: " << screen->logicalDotsPerInch();
    qDebug() << "Pixel density ratio: " << screen->devicePixelRatio();

    qmlRegisterSingletonType<GuiPainter>("weatherstation.gui", 1, 0, "GuiPainter", &qmlinstance);
    engine.load(QUrl(QStringLiteral("qrc:/res/MainView.qml")));

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    window->showFullScreen();

    m_in.setDevice(p_tcpSocket);
    m_in.setVersion(QDataStream::Qt_4_0);
    connect(p_tcpSocket, &QIODevice::readyRead, this, &GuiPainter::readDataFromServer);
    connect(this, &GuiPainter::readyToDraw, this, &GuiPainter::drawGui);

    QList<QHostAddress> addresses = QNetworkInterface::allAddresses();
    foreach (const QHostAddress &address, addresses)
    {
        if (address.protocol() == QAbstractSocket::IPv4Protocol)
        {
            m_ipaddr = address;
            break;
        }
    }
    if(m_ipaddr == QHostAddress(QHostAddress::LocalHost)) {
       p_tcpSocket->connectToHost(QHostAddress(m_ipaddr), 8786);
    }
    else {
        QStringList _address = m_ipaddr.toString().split(".");
        quint32 _addressLastPart = 2;
        while(_addressLastPart < 254)
        {
            QString curr = _address[0] +"."+ _address[1] +"."+ _address[2] +"."+ QString::number(_addressLastPart++);
            qDebug() << "address" << curr << " state: " << p_tcpSocket->state();
            p_tcpSocket->connectToHost(QHostAddress(curr), 8786);
            if(p_tcpSocket->waitForConnected(25)) {
                qDebug() << "Connected to " << curr + ":8786";
                break;
            }
        }
    }

    qDebug() << "Client ip " << m_ipaddr.toString();
    p_tcpSocket->write("ok");
}

QObject* GuiPainter::qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return instance();
}

const QString GuiPainter::temperature() const {
    return m_temperature;
}

const QString GuiPainter::pressure() const {
    return m_pressure;
}

const QString GuiPainter::humidity() const {
    return m_humidity;
}

const QVariantMap& GuiPainter::currentWeather() const {
    return m_currentWeather;
}

const QVariantMap& GuiPainter::forecast() const {
    return m_forecast;
}

const QVariantMap& GuiPainter::currentDateTime() const {
    return m_currentDateTime;
}

void GuiPainter::drawGui() {
    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

  //  QObject *outsideView = window->findChild<QObject *>("outside_view");

    QObject *outsideView = window->findChild<QObject *>("outside_view");
    QObject *forecastView = window->findChild<QObject *>("forecast_view");
    QObject *insideView = window->findChild<QObject *>("inside_view");

    // Connecting signals and slots
    QObject::connect(this, SIGNAL(forecastChanged()), outsideView, SLOT(updateGradientColor()));
    QObject::connect(this, SIGNAL(forecastChanged()), forecastView, SLOT(updateData()));
    QObject::connect(this, SIGNAL(insideChanged()), insideView, SLOT(updateData()));

  //  window->showFullScreen();
}

void GuiPainter::readDataFromServer() {
  m_in.startTransaction();

  m_in >> m_currentWeather;
  m_in >> m_forecast;
  m_in >> m_temperature;
  m_in >> m_pressure;
  m_in >> m_humidity;

  if (!m_in.commitTransaction()) 
    return;

  p_tcpSocket->write("ok");
  m_currentDateTime.insert("time", QTime::currentTime().toString(QString("hh:mm")));
  m_currentDateTime.insert("date", QDate::currentDate().toString(QString("dd.MM.yyyy")));

  if(!firstConnection) {
    firstConnection = true;
    emit readyToDraw();
  }
  
  emit insideChanged(); 
  emit timeChanged();
  emit forecastChanged();
}
