QT += core network
QT -= gui

CONFIG += c++11

TARGET = weathers-srv
CONFIG += console
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += main.cpp \
    sensors/i2cdevice.cpp \
    sensors/spidevice.cpp \
    sensors/nrf24l.cpp \
    sensors/lps25h.cpp \
    wsserver.cpp \
    wsthread.cpp \
    wumanager.cpp

DISTFILES +=

HEADERS += \
    sensors/i2cdevice.h \
    sensors/spidevice.h \
    sensors/lps25h.h \
    sensors/hts221.h \
    sensors/nrf24l.h \
    wsserver.h \
    wsthread.h \
    wumanager.h
