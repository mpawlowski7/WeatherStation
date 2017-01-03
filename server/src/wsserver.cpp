#include "wsserver.hpp"

WSServer* volatile WSServer::p_instance = nullptr;
WSServer* WSServer::instance()
{
    QMutex mutex;
    mutex.lock();
    if(p_instance == nullptr)
    {
        p_instance = new WSServer();
    }
    mutex.unlock();
    return p_instance;
}

void WSServer::startServer()
{
    qDebug() << "Starting server...";
    if(!this->listen(QHostAddress::Any, port))
    {
        qDebug() << "Could not start server...";
    }
    else
    {
        qDebug() << "Listening on port " << port << "...";
    }

}

void WSServer::incomingConnection(qintptr sd)
{
    WSThread *workHorse = new WSThread(sd, this);
    connect(workHorse, SIGNAL(finished()), workHorse, SLOT(deleteLater()));

    workHorse->start();
}



WSServer::~WSServer()
{

}
