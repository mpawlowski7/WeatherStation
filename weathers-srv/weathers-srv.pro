QT += core network
QT -= gui

CONFIG += c++11

TARGET = weathers-srv
CONFIG += console
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += main.cpp \
    sensors/hts221.cpp \
    sensors/i2cdevice.cpp \
    sensors/lps25h.cpp \
    sensors/spidevice.cpp \
    wumanager.cpp \
    wsserver.cpp \
    wsthread.cpp

DISTFILES +=

HEADERS += \
    sensors/hts221.h \
    sensors/i2cdevice.h \
    sensors/lps25h.h \
    sensors/spidevice.h \
    wumanager.h \
    wsserver.h \
    wsthread.h
