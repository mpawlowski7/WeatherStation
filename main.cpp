#include "gui/guipainter.h"
#include <QScreen>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QScreen* screen = app.screens().at(0);
    if(screen)
        qDebug() << screen->depth();

    GuiPainter::instance()->Init(engine);

    return app.exec();
}
