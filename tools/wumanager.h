#ifndef WUMANAGER_H
#define WUMANAGER_H

#include <QObject>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QNetworkAccessManager>
#include <QThread>
#include <QMutex>
#include <QTimer>

struct Weather {
    qreal temp_c;
    QString condition;
    QString relative_humidity;
    QString feelslike_c;
    qreal wind_kph;
    QString wind_dir;
};

class WUManager : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(WUManager)

private:
    const QString apiKey = "05489258f434bf7f";
    const QString location = "Rzeszow";
    const QString requestUrl = "http://api.wunderground.com/api/"+apiKey+"/conditions/forecast/q/Poland/"+location+".json";
    QNetworkAccessManager *manager;
    Weather current;

    static WUManager* volatile p_instance;
    WUManager(QObject *parent);
    ~WUManager() {}

public:
    static WUManager* instance();
    Weather GetCurrentWeather();
    void Update();

signals:

public slots:
    void replyFinished(QNetworkReply* reply);
    void sendRequest();
};

#endif // WUMANAGER_H
