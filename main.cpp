#include "gui/guipainter.h"
#include "gui/ledpainter.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterSingletonType<GuiPainter>("weatherstation.gui", 1, 0, "GuiPainter", &GuiPainter::qmlinstance);
    qmlRegisterSingletonType<LedPainter>("weatherstation.led", 1, 0, "LedPainter", &LedPainter::qmlinstance);
    engine.load(QUrl(QStringLiteral("qrc:/res/main.qml")));

    return app.exec();
}
