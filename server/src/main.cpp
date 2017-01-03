#include "wsserver.hpp"

#include <QCoreApplication>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    qSetMessagePattern("%{time [hh:mm:ss]}[%{file}(%{line})]: %{message}");

    WUManager::instance()->init();
    WSServer::instance()->startServer();

    return a.exec();
}
