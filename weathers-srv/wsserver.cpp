#include "wsserver.h"

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
    if(this->listen((QHostAddress::Any)), port)
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
    // We have a new connection
    qDebug() << sd << " Connecting...";

    // Every new connection will be run in a newly created thread
    WSThread *workHorse = new WSThread(sd, this);

    // connect signal/slot
    // once a thread is not needed, it will be beleted later
    connect(workHorse, SIGNAL(finished()), workHorse, SLOT(deleteLater()));

    workHorse->start();
}



WSServer::~WSServer()
{

}
