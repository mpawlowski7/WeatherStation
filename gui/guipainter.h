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
    Q_PROPERTY(qreal windDirOut READ windDirOut NOTIFY labelsChanged)
    Q_PROPERTY(QString windSpeedOut READ windSpeedOut NOTIFY labelsChanged)
    Q_PROPERTY(QString humidityOut READ humidityOut NOTIFY labelsChanged)
    Q_PROPERTY(QString conditionOut READ conditionOut NOTIFY labelsChanged)
    Q_PROPERTY(QString conditionIcon READ conditionIcon NOTIFY labelsChanged)
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
    qreal m_windDirOut;
    QString m_windSpeedOut;
    QString m_conditionOut;
    QString m_conditionIcon;


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
    m_windDirOut(315.0),
    m_windSpeedOut(QString("0.0")),
    m_conditionOut(QString("Empty")),
    m_conditionIcon(QString("clear"))
    {
    }
    ~GuiPainter() {}

public:
    static QObject* qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static GuiPainter* instance();
    void Init(QQmlApplicationEngine & engine);
    QString temperature();
    QString pressure();
    QString humidity();
    QString temperatureOut();
    QString feelslikeOut();
    qreal windDirOut();
    QString windSpeedOut();
    QString humidityOut();
    QString conditionOut();
    QString conditionIcon();
    QString currentTime();

public slots:
    void updateGui();
    void startReadingData();
};

#endif // GUIPAINTER_H
