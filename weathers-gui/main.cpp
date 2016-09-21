#include "guipainter.h"
#include <QScreen>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qSetMessagePattern("%{time [hh:mm:ss]}[%{file}(%{line})]: %{message}");

    QScreen* screen = app.screens().at(0);
    if(screen)
    {
        qDebug() << "Screen depth: " << screen->depth();
        qDebug() << "Scren size: " << screen->size();
    }

 //   QQmlApplicationEngine engine;
 //   engine.load(QUrl(QStringLiteral("qrc:res/MainView.qml")));
    GuiPainter::instance()->init();

    return app.exec();
}
