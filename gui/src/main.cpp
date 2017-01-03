#include "guipainter.h"

#ifdef __ANDROID__
#include <QtAndroidExtras>

void keep_screen_on(bool on) {
    QtAndroid::runOnAndroidThread([on]{
        QAndroidJniObject activity = QtAndroid::androidActivity();
        if (activity.isValid()) {
            QAndroidJniObject window =
                    activity.callObjectMethod("getWindow", "()Landroid/view/Window;");

            if (window.isValid()) {
                const int FLAG_KEEP_SCREEN_ON = 128;
                if (on) {
                    window.callMethod<void>("addFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
                } else {
                    window.callMethod<void>("clearFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
                }
            }
        }
        QAndroidJniEnvironment env;
        if (env->ExceptionCheck()) {
            env->ExceptionClear();
        }
    });
}
#endif

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);
  qSetMessagePattern("%{time [hh:mm:ss]}[%{file}(%{line})]: %{message}");

  GuiPainter::instance()->init(app);

  #ifdef __ANDROID__
    keep_screen_on(true);
  #endif

  return app.exec();
}
