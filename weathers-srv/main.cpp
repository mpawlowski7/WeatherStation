#include "wsserver.h"

#include <QCoreApplication>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    WSServer::instance()->startServer();

    return a.exec();
}
