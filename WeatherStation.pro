QT += core
QT += gui
QT += qml quick

unix:INCLUDEPATH += "/home/mipw/tools/rpi/sysroot/usr/include" \
                    "/home/mipw/tools/rpi/sysroot/usr/local/include" \
                    "/home/mipw/tools/rpi/sysroot/usr/include/arm-linux-gnueabihf" \
                    "/home/mipw/tools/rpi/sysroot/usr/include/c++/4.9.2"

CONFIG += c++14
QMAKE_CXXFLAGS += -pthread
LIBS += -pthread

TARGET = WeatherStation
target.path = /home/pi
INSTALLS += target

CONFIG += console
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += \
    sensors/i2cdevice.cpp \
    sensors/lis35de.cpp \
    sensors/lsm9ds1.cpp \
    sensors/hts221.cpp \
    sensors/lps25h.cpp \
    sensors/ahrs.cpp \
    gui/guipainter.cpp \
    gui/ledpainter.cpp \
    main.cpp

HEADERS += \
    sensors/i2cdevice.h \
    sensors/lis35de.h \
    sensors/lsm9ds1.h \
    sensors/hts221.h \
    sensors/lps25h.h \
    sensors/ahrs.h \
    gui/guipainter.h \
    gui/ledpainter.h

DISTFILES +=

RESOURCES += \
    gui.qrc
