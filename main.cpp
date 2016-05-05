#include "gui/guipainter.h"
//#include "gui/ledpainter.h"
//#include "tools/wumanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    GuiPainter::instance()->Init(engine);

    return app.exec();
}
