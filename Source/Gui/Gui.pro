TEMPLATE = app

QT += qml quick gui network
android: QT += androidextras
CONFIG += c++11

SOURCES += main.cpp \
    GUIPainter.cpp

RESOURCES += \
    Resources/Gui.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    Resources/Controls/Button.qml \
    Resources/Controls/Loader.qml \
    Resources/Controls/Text.qml \
    Resources/Controls/Variables.qml \
    Resources/Qml/Drawer.qml \
    Resources/Qml/FontAwesome.qml \
    Resources/Qml/ForecastView.qml \
    Resources/Qml/InsideView.qml \
    Resources/Qml/LedMatrix.qml \
    Resources/Qml/MainView.qml \
    Resources/Qml/OutsideView.qml \
    Resources/Qml/SingleDayView.qml \
    Resources/Qml/TextShadow.qml \
    Resources/Qml/WeatherIcon.qml \
    Resources/Qml/DisplayScale.qml \
    Android/gradle/wrapper/gradle-wrapper.jar \
    Android/AndroidManifest.xml \
    Android/gradlew \
    Android/res/values/libs.xml \
    Android/build.gradle \
    Android/gradle/wrapper/gradle-wrapper.properties \
    Android/gradlew.bat


HEADERS += \
    GUIPainter.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/Android
