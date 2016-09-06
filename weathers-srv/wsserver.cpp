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

bool WSServer::Init()
{

}

bool WSServer::Configure()
{

}

void WSServer::StartTransmission()
{
    int port = 8786;

    if(this->listen((QHostAddress::Any)), port)
    {
        qDebug() << "Could not start server...";
    }
    else
    {
        qDebug() << "Listening on port " << port << "...";
    }
}

void WSServer::StopTransmission()
{

}

WSServer::~WSServer()
{

}
