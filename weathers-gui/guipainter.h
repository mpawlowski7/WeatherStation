#ifndef GUIPAINTER_H
#define GUIPAINTER_H

#include <QMutex>
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
//    Q_PROPERTY(QString temperature READ temperature NOTIFY insideChanged)
//    Q_PROPERTY(QString pressure READ pressure NOTIFY insideChanged)
//    Q_PROPERTY(QString humidity READ humidity NOTIFY insideChanged)
//    Q_PROPERTY(QVariantMap currentWeather READ currentWeather NOTIFY forecastChanged)
//    Q_PROPERTY(QVariantMap forecast READ forecast NOTIFY forecastChanged)
    Q_PROPERTY(QVariantMap currentDateTime READ currentDateTime NOTIFY timeChanged)
//    Q_PROPERTY(void ToggleLedMatrix READ ToggleLedMatrix)
//    Q_PROPERTY(void Update READ Update)

signals:
    void forecastChanged();
    void insideChanged();
    void outsideChanged();
    void timeChanged();

private:
    static GuiPainter* volatile p_instance;
    GuiPainter(QObject* parent = 0) : QObject(parent)
    {
    }
    ~GuiPainter() {}
    QVariantMap m_currentDateTime;

public:
    static QObject* qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static GuiPainter* instance();
    void init(QQmlApplicationEngine & engine);
    void connectServer();
    const QString temperature() const;
    const QString pressure() const;
    const QString humidity() const;
    const QVariantMap& currentWeather() const;
    const QVariantMap& forecast() const;
    const QVariantMap& currentDateTime() const;

public slots:
    void updateGui();
    void startReadingData();
};

#endif // GUIPAINTER_H
