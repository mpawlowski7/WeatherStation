#ifndef WUMANAGER_H
#define WUMANAGER_H

#include <QObject>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QJsonArray>
#include <QNetworkAccessManager>
#include <QThread>
#include <QMutex>
#include <QTimer>
#include <QEventLoop>
#include <QVector>
#include <QDateTime>
#include <memory>

class WUManager : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(WUManager)

private:
    const QString apiKey = "05489258f434bf7f";
    const QString location = "";
    const QString requestUrl = "http://api.wunderground.com/api/"+apiKey+"/conditions/forecast10day/q/autoip.json";
    const QDateTime currentDate;
    QNetworkAccessManager *manager;
    QVariantMap currentWeather;
    QVariantMap forecast10Days;

    static WUManager* volatile p_instance;
    WUManager(QObject *parent);
    ~WUManager() { delete manager; }
    void ProcessForecast(QJsonDocument& doc);

public:
    static WUManager* instance();
    const QVariantMap& GetCurrentWeather() const;
    const QVariantMap& Get10DaysForecast() const;
    const QString GetLocation() const;
    void SetLocation();
    void Init();
    void Update();

signals:
    void replyProcessed();

public slots:
    void replyFinished(QNetworkReply* reply);
    void sendRequest();
};

#endif // WUMANAGER_H
