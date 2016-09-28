#ifndef GUIPAINTER_H
#define GUIPAINTER_H

#include <QMutex>
#include <QGuiApplication>
#include <QScreen>
#include <QObject>
#include <QQuickWindow>
#include <QQmlApplicationEngine>
#include <QQuaternion>
#include <QThread>
#include <QTime>
#include <QTimer>
#include <QVariantMap>
#include <QTcpSocket>
#include <QNetworkSession>
#include <QWindow>

#include <iostream>

class GuiPainter : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(GuiPainter)
    Q_PROPERTY(QString temperature READ temperature NOTIFY insideChanged)
    Q_PROPERTY(QString pressure READ pressure NOTIFY insideChanged)
    Q_PROPERTY(QString humidity READ humidity NOTIFY insideChanged)
    Q_PROPERTY(QVariantMap currentWeather READ currentWeather NOTIFY forecastChanged)
    Q_PROPERTY(QVariantMap forecast READ forecast NOTIFY forecastChanged)
    Q_PROPERTY(QVariantMap currentDateTime READ currentDateTime NOTIFY timeChanged)
//    Q_PROPERTY(void ToggleLedMatrix READ ToggleLedMatrix)
//    Q_PROPERTY(void Update READ Update)

signals:
    void forecastChanged();
    void insideChanged();
    void outsideChanged();
    void timeChanged();
    void readyToDraw();

private:
    static GuiPainter* volatile p_instance;
    GuiPainter(QObject* parent = 0);
    ~GuiPainter() {}
    QQmlApplicationEngine engine;
    QScreen* screen;
    QTcpSocket *p_tcpSocket;    
    QDataStream m_in;
    QString m_ipaddr;
    QVariantMap m_currentWeather;
    QVariantMap m_forecast;
    QVariantMap m_currentDateTime;
    QString m_temperature;
    QString m_pressure;
    QString m_humidity;
    bool firstConnection;


public:
    static QObject* qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static GuiPainter* instance();
    void init(QGuiApplication& app);
    void connectServer();
    const QString temperature() const;
    const QString pressure() const;
    const QString humidity() const;
    const QVariantMap& currentWeather() const;
    const QVariantMap& forecast() const;
    const QVariantMap& currentDateTime() const;

public slots:
    void drawGui();
    void readDataFromServer();

};

#endif // GUIPAINTER_H
