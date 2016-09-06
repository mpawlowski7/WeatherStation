#include "guipainter.h"
#include <QScreen>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    qSetMessagePattern("%{time [hh:mm:ss]}[%{file}(%{line})]: %{message}");

    QScreen* screen = app.screens().at(0);
    if(screen)
    {
        qDebug() << "Screen depth: " << screen->depth();
        qDebug() << "Scren size: " << screen->size();
    }

    GuiPainter::instance()->init(engine);

    return app.exec();
}
