#include "ledpainter.h"

LedPainter::LedPainter(QObject* parent = 0) : QObject(parent), activated(false)
{
    int fbfd = 0;
    const char *fb1_file = "/dev/fb1";
    if (fbfd == 0 && (fbfd = open(fb1_file, O_RDWR)) < 0)
    {
       // Open port for reading and writing
       fprintf(stderr, "Failed to open fb1 %s", fb1_file);
       exit(1);
    }
    if(fb == nullptr && fbfd != 0)
    {
        fb = static_cast<fb_t*>(mmap (NULL, 128, PROT_READ | PROT_WRITE, MAP_SHARED, fbfd, 0));
    }

    workHorse = new QThread(this);
    timer = new QTimer(0);

    timer->setInterval(1000);
    timer->moveToThread(workHorse);
    connect(timer, SIGNAL(timeout()), this, SLOT(randomness()));
    connect(workHorse, SIGNAL(started()), timer, SLOT(start()));
}

LedPainter* volatile LedPainter::p_instance = nullptr;
LedPainter* LedPainter::instance()
{
    QMutex mutex;
    mutex.lock();
    if(p_instance == nullptr)
    {
        p_instance = new LedPainter();
    }
    mutex.unlock();
    return p_instance;
}

QObject* LedPainter::qmlinstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    return instance();
}

uint16_t LedPainter::RgbToHex16(QColor val)
{
    uint16_t value = 0;
    value = (uint16_t(val.red() >> 3) << 11) | ((val.green() >> 2) << 5) | (val.blue() >> 3);
    return value;
}

void LedPainter::drawPixel(QColor color, QPoint px)
{
    fb->pixels[px.x()][px.y()] = RgbToHex16(color);
}

void LedPainter::DrawImage(QColor color, uint16_t img[8][8])
{
    for(int i = 0 ; i < 8; i++)
    {
        memcpy(&fb->pixels[i], &img[i], sizeof(img[0]));
    }
    SetColor(color);
}

void LedPainter::SetColor(QColor color)
{
    for(int i = 0; i<8; i++)
    {
        for(int j = 0; j<8; j++)
        {
            if(fb->pixels[i][j] > 0)
            {
                fb->pixels[i][j] = RgbToHex16(color);
            }
        }
    }
}

void LedPainter::clear()
{
    uint16_t empty[8][8] = { 0 };
    for(int i = 0 ; i < 8; i++)
    {
        memcpy(&fb->pixels[i], &empty[i], sizeof(empty[0]));
    }
}

bool LedPainter::isActive()
{
    return activated;
}

void LedPainter::activate()
{
    activated = true;
    workHorse->start();
}

void LedPainter::deactivate()
{
    activated = false;
    workHorse->quit();
    clear();
}

void LedPainter::randomness()
{
    QPoint px;
    QColor color;
    px.setX(rand() % 8);
    px.setY(rand() % 8);
    color.setRed((rand() % 2) * 255);
    color.setGreen((rand() % 2) * 255);
    color.setBlue((rand() % 2) * 255);

    drawPixel(color, px);
}
