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
#include <QVariantMap>

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
    Q_PROPERTY(QString temperatureOut READ temperatureOut NOTIFY labelsChanged)
    Q_PROPERTY(QString feelslikeOut READ feelslikeOut NOTIFY labelsChanged)
    Q_PROPERTY(qreal windDirOut READ windDirOut NOTIFY labelsChanged)
    Q_PROPERTY(QString windSpeedOut READ windSpeedOut NOTIFY labelsChanged)
    Q_PROPERTY(QString humidityOut READ humidityOut NOTIFY labelsChanged)
    Q_PROPERTY(QString conditionOut READ conditionOut NOTIFY labelsChanged)
    Q_PROPERTY(QString conditionIcon READ conditionIcon NOTIFY labelsChanged)
//    Q_PROPERTY(void ToggleLedMatrix READ ToggleLedMatrix)
//    Q_PROPERTY(void Update READ Update)

signals:
    void forecastChanged();
    void insideChanged();
    void outsideChanged();
    void labelsChanged();

private:
    static GuiPainter* volatile p_instance;
    GuiPainter(QObject* parent = 0) : QObject(parent)
    {
    }
    ~GuiPainter() {}

public:
    static QObject* qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static GuiPainter* instance();
    void Init(QQmlApplicationEngine & engine);
    const QString temperature() const;
    const QString pressure() const;
    const QString humidity() const;
    const QVariantMap& currentWeather() const;
    const QVariantMap& forecast() const;
    const QString temperatureOut() const;
    const QString feelslikeOut() const;
    qreal windDirOut() const;
    const QString windSpeedOut() const;
    const QString humidityOut() const;
    const QString conditionOut() const;
    const QString conditionIcon() const;
    const QString currentTime() const;

public slots:
    void updateGui();
    void startReadingData();
};

#endif // GUIPAINTER_H
