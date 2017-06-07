QT += core network
QT -= gui

CONFIG += c++11

TARGET = server
CONFIG += console
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += main.cpp \
    Sensors/I2CDevice.cpp \
  #  Sensors/SPIDevice.cpp \
  #  Sensors/NRF24L.cpp \
    Sensors/LPS25H.cpp \
    WSServer.cpp \
    WSThread.cpp \
    WUManager.cpp \
    Sensors/HTS221.cpp

DISTFILES +=

HEADERS += \
    Sensors/I2CDevice.h \
  #  Sensors/SPIDevice.h \
  #  Sensors/NRF24L.h \
    Sensors/LPS25H.h \
    WSServer.h \
    WSThread.h \
    WUManager.h \
    Sensors/HTS221.h

INCLUDEPATH += \
    Sensors\
