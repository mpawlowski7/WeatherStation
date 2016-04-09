#ifndef GUIPAINTER_H
#define GUIPAINTER_H

#include "sensors/lis35de.h"
#include "sensors/lsm9ds1.h"
#include "sensors/lps25h.h"
#include "sensors/hts221.h"
#include "sensors/ahrs.h"
#include "ledpainter.h"

#include <QGuiApplication>
#include <QObject>
#include <QQuickWindow>
#include <QQmlApplicationEngine>
#include <QQuaternion>
#include <QThread>
#include <QTime>
#include <QTimer>

#include <iostream>

class GuiPainter : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(GuiPainter)
    Q_PROPERTY(QString temperature READ temperature NOTIFY temperatureChanged)
    Q_PROPERTY(QString pressure READ pressure NOTIFY pressureChanged)
    Q_PROPERTY(QString humidity READ humidity NOTIFY humidityChanged)
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY timeChanged)
//    Q_PROPERTY(void ToggleLedMatrix READ ToggleLedMatrix)
//    Q_PROPERTY(void Update READ Update)

signals:
    void temperatureChanged();
    void pressureChanged();
    void humidityChanged();
    void timeChanged();
    void ledMatrixOn();
    void ledMatrixOff();

private:
    QString m_temp;
    QString m_press;
    QString m_humidity;
    QString m_time;


   // bool m_readingData = false;
    static GuiPainter* volatile p_instance;
    GuiPainter(QObject* parent = 0) : QObject(parent),
    m_temp(QString("0.0")),
    m_press(QString("0.0")),
    m_humidity(QString("0.0")),
    m_time(QString("0.0"))
    {
    }
    ~GuiPainter() {}

public:
    static QObject* qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static GuiPainter* instance();
    QString temperature();
    QString pressure();
    QString humidity();
    QString currentTime();
    void UpdateTemperatureLabel();
    void UpdateHumidityLabel();
    void UpdatePressureLabel();
    void UpdateTimeLabel();

public slots:
    void updateGui();
    void startReadingData();
};

#endif // GUIPAINTER_H
