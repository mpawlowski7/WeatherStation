#ifndef LEDPAINTER_H
#define LEDPAINTER_H

#include <linux/fb.h>
#include <sys/mman.h>
#include <stdint.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <memory>
#include <unistd.h>

#include <QObject>
#include <QMutex>
#include <QtQml>
#include <QColor>
#include <QPoint>

#include "guipainter.h"

class LedPainter : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(LedPainter)

private:
    struct fb_t
    {
        uint16_t pixels[8][8];
    };
    struct fb_t* fb = nullptr;

    bool activated;
    QThread* workHorse;
    QTimer* timer;
    static LedPainter* volatile p_instance;
    LedPainter(QObject* parent);
    ~LedPainter() {}
    uint16_t RgbToHex16(QColor val);
    void SetColor(QColor color);

public:
    static QObject* qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine);
    static LedPainter* instance();
    void DrawImage(QColor color, uint16_t img[8][8]);
    bool isActive();
public slots:
    void drawPixel(QColor color, QPoint px);
    void activate();
    void deactivate();
    void clear();
    void randomness();
};

#endif // LEDPAINTER_H
