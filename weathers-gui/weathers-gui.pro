TEMPLATE = app

QT += qml quick gui network
android: QT += androidextras
CONFIG += c++11

SOURCES += main.cpp \
    guipainter.cpp

RESOURCES += \
    gui.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    res/controls/Button.qml \
    res/controls/Loader.qml \
    res/controls/Text.qml \
    res/controls/Variables.qml \
    res/Drawer.qml \
    res/FontAwesome.qml \
    res/ForecastView.qml \
    res/InsideView.qml \
    res/LedMatrix.qml \
    res/main (kopia).qml \
    res/MainView.qml \
    res/OutsideView.qml \
    res/SingleDayView.qml \
    res/TextShadow.qml \
    res/WeatherIcon.qml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

HEADERS += \
    guipainter.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
