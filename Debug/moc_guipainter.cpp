/****************************************************************************
** Meta object code from reading C++ file 'guipainter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../gui/guipainter.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'guipainter.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_GuiPainter_t {
    QByteArrayData data[14];
    char stringdata0[169];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_GuiPainter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_GuiPainter_t qt_meta_stringdata_GuiPainter = {
    {
QT_MOC_LITERAL(0, 0, 10), // "GuiPainter"
QT_MOC_LITERAL(1, 11, 18), // "temperatureChanged"
QT_MOC_LITERAL(2, 30, 0), // ""
QT_MOC_LITERAL(3, 31, 15), // "pressureChanged"
QT_MOC_LITERAL(4, 47, 15), // "humidityChanged"
QT_MOC_LITERAL(5, 63, 11), // "timeChanged"
QT_MOC_LITERAL(6, 75, 11), // "ledMatrixOn"
QT_MOC_LITERAL(7, 87, 12), // "ledMatrixOff"
QT_MOC_LITERAL(8, 100, 9), // "updateGui"
QT_MOC_LITERAL(9, 110, 16), // "startReadingData"
QT_MOC_LITERAL(10, 127, 11), // "temperature"
QT_MOC_LITERAL(11, 139, 8), // "pressure"
QT_MOC_LITERAL(12, 148, 8), // "humidity"
QT_MOC_LITERAL(13, 157, 11) // "currentTime"

    },
    "GuiPainter\0temperatureChanged\0\0"
    "pressureChanged\0humidityChanged\0"
    "timeChanged\0ledMatrixOn\0ledMatrixOff\0"
    "updateGui\0startReadingData\0temperature\0"
    "pressure\0humidity\0currentTime"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_GuiPainter[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       4,   62, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x06 /* Public */,
       3,    0,   55,    2, 0x06 /* Public */,
       4,    0,   56,    2, 0x06 /* Public */,
       5,    0,   57,    2, 0x06 /* Public */,
       6,    0,   58,    2, 0x06 /* Public */,
       7,    0,   59,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       8,    0,   60,    2, 0x0a /* Public */,
       9,    0,   61,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
      10, QMetaType::QString, 0x00495001,
      11, QMetaType::QString, 0x00495001,
      12, QMetaType::QString, 0x00495001,
      13, QMetaType::QString, 0x00495001,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,

       0        // eod
};

void GuiPainter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        GuiPainter *_t = static_cast<GuiPainter *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->temperatureChanged(); break;
        case 1: _t->pressureChanged(); break;
        case 2: _t->humidityChanged(); break;
        case 3: _t->timeChanged(); break;
        case 4: _t->ledMatrixOn(); break;
        case 5: _t->ledMatrixOff(); break;
        case 6: _t->updateGui(); break;
        case 7: _t->startReadingData(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::temperatureChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::pressureChanged)) {
                *result = 1;
            }
        }
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::humidityChanged)) {
                *result = 2;
            }
        }
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::timeChanged)) {
                *result = 3;
            }
        }
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::ledMatrixOn)) {
                *result = 4;
            }
        }
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::ledMatrixOff)) {
                *result = 5;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        GuiPainter *_t = static_cast<GuiPainter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->temperature(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->pressure(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->humidity(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->currentTime(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    Q_UNUSED(_a);
}

const QMetaObject GuiPainter::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_GuiPainter.data,
      qt_meta_data_GuiPainter,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *GuiPainter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *GuiPainter::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_GuiPainter.stringdata0))
        return static_cast<void*>(const_cast< GuiPainter*>(this));
    return QObject::qt_metacast(_clname);
}

int GuiPainter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void GuiPainter::temperatureChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}

// SIGNAL 1
void GuiPainter::pressureChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, Q_NULLPTR);
}

// SIGNAL 2
void GuiPainter::humidityChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, Q_NULLPTR);
}

// SIGNAL 3
void GuiPainter::timeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, Q_NULLPTR);
}

// SIGNAL 4
void GuiPainter::ledMatrixOn()
{
    QMetaObject::activate(this, &staticMetaObject, 4, Q_NULLPTR);
}

// SIGNAL 5
void GuiPainter::ledMatrixOff()
{
    QMetaObject::activate(this, &staticMetaObject, 5, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
