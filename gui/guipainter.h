#ifndef GUIPAINTER_H
#define GUIPAINTER_H

#include "sensors/lis35de.h"
#include "sensors/lsm9ds1.h"
#include "sensors/lps25h.h"
#include "sensors/hts221.h"
#include "sensors/ahrs.h"
#include "ledpainter.h"
#include "tools/wumanager.h"

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
    Q_PROPERTY(QString temperature READ temperature NOTIFY labelsChanged)
    Q_PROPERTY(QString pressure READ pressure NOTIFY labelsChanged)
    Q_PROPERTY(QString humidity READ humidity NOTIFY labelsChanged)
    Q_PROPERTY(QString temperatureOut READ temperatureOut NOTIFY labelsChanged)
    Q_PROPERTY(QString feelslikeOut READ feelslikeOut NOTIFY labelsChanged)
    Q_PROPERTY(QString windDirOut READ windDirOut NOTIFY labelsChanged)
    Q_PROPERTY(QString windSpeedOut READ windSpeedOut NOTIFY labelsChanged)
    Q_PROPERTY(QString humidityOut READ humidityOut NOTIFY labelsChanged)
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY labelsChanged)
//    Q_PROPERTY(void ToggleLedMatrix READ ToggleLedMatrix)
//    Q_PROPERTY(void Update READ Update)

signals:
    void labelsChanged();

private:
    QString m_temp;
    QString m_press;
    QString m_humidity;
    QString m_time;
    QString m_tempOut;
    QString m_feelslikeOut;
    QString m_humidityOut;
    QString m_windDirOut;
    QString m_windSpeedOut;


   // bool m_readingData = false;
    static GuiPainter* volatile p_instance;
    GuiPainter(QObject* parent = 0) : QObject(parent),
    m_temp(QString("0.0")),
    m_press(QString("0.0")),
    m_humidity(QString("0.0")),
    m_time(QString("0.0")),
    m_tempOut(QString("0.0")),
    m_feelslikeOut(QString("0.0")),
    m_humidityOut(QString("0.0")),
    m_windDirOut(QString("0.0")),
    m_windSpeedOut(QString("0.0"))
    {
    }
    ~GuiPainter() {}

public:
    static QObject* qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static GuiPainter* instance();
    QString temperature();
    QString pressure();
    QString humidity();
    QString temperatureOut();
    QString feelslikeOut();
    QString windDirOut();
    QString windSpeedOut();
    QString humidityOut();
    QString currentTime();

public slots:
    void updateGui();
    void startReadingData();
};

#endif // GUIPAINTER_H
