#include "wumanager.h"

WUManager::WUManager(QObject *parent = 0) : QObject(parent)
{
    manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));
    sendRequest();

    QThread* workHorse = new QThread(this);
    QTimer* timer = new QTimer(0);

    timer->setInterval(900000);    // every hour read weather data
    timer->moveToThread(workHorse);
    connect(timer, SIGNAL(timeout()), this, SLOT(sendRequest()));
    connect(workHorse, SIGNAL(started()), timer, SLOT(start()));
    workHorse->start();
}

WUManager* volatile WUManager::p_instance = nullptr;
WUManager* WUManager::instance()
{
    QMutex mutex;
    mutex.lock();
    if(p_instance == nullptr)
    {
        p_instance = new WUManager();
    }
    mutex.unlock();
    return p_instance;
}

Weather WUManager::GetCurrentWeather()
{
    return current;
}

void WUManager::sendRequest()
{
    manager->get(QNetworkRequest(QUrl(requestUrl)));
}

void WUManager::replyFinished(QNetworkReply *reply)
{
   QByteArray byteArray;
   QJsonParseError err;
   QJsonDocument doc;

   byteArray = reply->readAll();
   doc  = QJsonDocument::fromJson(byteArray, &err);

   if(!err.NoError && doc.isObject())
   {
        QJsonObject obj = doc.object().value("current_observation").toObject();

        current.condition = obj.value("weather").toString();
        current.temp_c = obj.value("temp_c").toDouble();
        current.feelslike_c = obj.value("feelslike_c").toString();
        current.relative_humidity = obj.value("relative_humidity").toString();
        current.wind_dir = obj.value("wind_degrees").toDouble();
        current.wind_kph = obj.value("wind_kph").toDouble();
        current.icon = obj.value("icon").toString();
        qDebug() << current.condition;
        qDebug() << current.temp_c;
        qDebug() << current.feelslike_c;
        qDebug() << current.relative_humidity;
        qDebug() << current.wind_dir;
        qDebug() << current.wind_kph;
        qDebug() << current.icon;
   }
   else
   {
       qDebug () << "Shit's broken";
   }
}
