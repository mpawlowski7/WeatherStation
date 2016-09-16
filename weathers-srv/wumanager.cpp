#include "wumanager.h"

WUManager::WUManager(QObject *parent = 0) : QObject(parent)
{
    manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));

    currentWeather.insert("location", "");
    currentWeather.insert("weather", "");
    currentWeather.insert("temp_c", "");
    currentWeather.insert("feelslike_c", "");
    currentWeather.insert("relative_humidity", "");
    currentWeather.insert("wind_degrees", "");
    currentWeather.insert("wind_kph", "");
    currentWeather.insert("icon", "");

    forecast10Days.insert("date", QVariantList());
    forecast10Days.insert("temp_high", QVariantList());
    forecast10Days.insert("temp_low", QVariantList());
    forecast10Days.insert("conditions", QVariantList());
    forecast10Days.insert("icon", QVariantList());
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

void WUManager::init()
{
    sendRequest();

    QThread* workHorse = new QThread(this);
    QTimer* timer = new QTimer(0);
    QEventLoop* loop = new QEventLoop();

    timer->setInterval(900000);    // every hour read weather data
    timer->moveToThread(workHorse);
    connect(this,  SIGNAL(replyProcessed()), loop, SLOT(quit()) );
    connect(timer, SIGNAL(timeout()), this, SLOT(sendRequest()));
    connect(workHorse, SIGNAL(started()), timer, SLOT(start()));
    workHorse->start();
    loop->exec();

    QThread* workHorseSensors = new QThread(this);
    QTimer* timerSensors = new QTimer(0);

    timerSensors->setInterval(1000);
    timerSensors->moveToThread(workHorse);
    connect(timerSensors, SIGNAL(timeout()), this, SLOT(readSensors()));
    connect(workHorseSensors, SIGNAL(started()), timerSensors, SLOT(start()));
    workHorseSensors->start();
}

const QVariantMap& WUManager::GetCurrentWeather() const
{
    return currentWeather;
}

const QVariantMap& WUManager::Get10DaysForecast() const
{
    return forecast10Days;
}

void WUManager::sendRequest()
{
    manager->get(QNetworkRequest(QUrl(requestUrl)));
}

void WUManager::readSensors()
{
    LPS25H::instance()->ReadSensor();
    HTS221::instance()->ReadSensor();
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
        ProcessForecast(doc);
   }
   else
   {
       qDebug () << "Error when connecting to server";
   }

   emit replyProcessed();
}

void WUManager::ProcessForecast(QJsonDocument &doc)
{
    std::unique_ptr<QJsonObject> obj(new QJsonObject());
    std::unique_ptr<QJsonArray> arr(new QJsonArray());
    // Get current weather condtion
    *obj = doc.object().value("current_observation").toObject();
    //Get rest of the week forecast
    *arr = doc.object().value("forecast").toObject().value("simpleforecast").toObject().value("forecastday").toArray();

    if(nullptr != obj)
    {
        currentWeather["location"] = obj->value("display_location").toObject().value("city").toString()+", "+obj->value("display_location").toObject().value("country").toString();
        currentWeather["weather"] = obj->value("weather").toString();
        currentWeather["temp_c"] = QString::number(obj->value("temp_c").toDouble(), 'f', 1);
        currentWeather["feelslike_c"] = obj->value("feelslike_c").toString();
        currentWeather["relative_humidity"] = obj->value("relative_humidity").toString();
        currentWeather["wind_dir"] = obj->value("wind_degrees").toDouble();
        currentWeather["wind_kph"] = QString::number(obj->value("wind_kph").toDouble(), 'f', 1);
        currentWeather["icon"] = obj->value("icon").toString();
    }

    if(nullptr != arr)
    {
        QVariantList temp_highList;
        QVariantList temp_lowList;
        QVariantList iconList;
        QVariantList conditionsList;
        QVariantList dateList;
        uint8_t dayCount = arr->count();

        for(uint8_t i=1; i<dayCount; i++)
        {
            temp_highList.append(arr->at(i).toObject().value("high").toObject().value("celsius").toString());
            temp_lowList.append(arr->at(i).toObject().value("low").toObject().value("celsius").toString());
            iconList.append(arr->at(i).toObject().value("icon").toString());
            conditionsList.append(arr->at(i).toObject().value("conditions").toString());
            dateList.append(currentDate.currentDateTime().addDays(i));
        }

        forecast10Days.clear();

        forecast10Days.insert("date", dateList);
        forecast10Days.insert("temp_high", temp_highList);
        forecast10Days.insert("temp_low", temp_lowList);
        forecast10Days.insert("conditions", conditionsList);
        forecast10Days.insert("icon", iconList);

        qDebug() << forecast10Days["date"].toList().at(0).toString()
                 << "|" << forecast10Days["temp_high"].toList().at(0).toString()
                 << "|"  << forecast10Days["temp_low"].toList().at(0).toString()
                 << "|" << forecast10Days["conditions"].toList().at(0).toString()
                 << "|" << forecast10Days["icon"].toList().at(0).toString();
    }
}
