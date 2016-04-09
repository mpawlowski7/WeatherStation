/****************************************************************************
** Meta object code from reading C++ file 'guipainter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../gui/guipainter.h"
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
    QByteArrayData data[10];
    char stringdata0[149];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_GuiPainter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_GuiPainter_t qt_meta_stringdata_GuiPainter = {
    {
QT_MOC_LITERAL(0, 0, 10), // "GuiPainter"
QT_MOC_LITERAL(1, 11, 23), // "TemperatureLabelUpdated"
QT_MOC_LITERAL(2, 35, 0), // ""
QT_MOC_LITERAL(3, 36, 20), // "PressureLabelUpdated"
QT_MOC_LITERAL(4, 57, 20), // "HumidityLabelUpdated"
QT_MOC_LITERAL(5, 78, 16), // "TimeLabelUpdated"
QT_MOC_LITERAL(6, 95, 14), // "GetTemperature"
QT_MOC_LITERAL(7, 110, 11), // "GetPressure"
QT_MOC_LITERAL(8, 122, 11), // "GetHumidity"
QT_MOC_LITERAL(9, 134, 14) // "GetCurrentTime"

    },
    "GuiPainter\0TemperatureLabelUpdated\0\0"
    "PressureLabelUpdated\0HumidityLabelUpdated\0"
    "TimeLabelUpdated\0GetTemperature\0"
    "GetPressure\0GetHumidity\0GetCurrentTime"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_GuiPainter[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       4,   38, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x06 /* Public */,
       3,    0,   35,    2, 0x06 /* Public */,
       4,    0,   36,    2, 0x06 /* Public */,
       5,    0,   37,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       6, QMetaType::QString, 0x00495001,
       7, QMetaType::QString, 0x00495001,
       8, QMetaType::QString, 0x00495001,
       9, QMetaType::QString, 0x00495001,

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
        case 0: _t->TemperatureLabelUpdated(); break;
        case 1: _t->PressureLabelUpdated(); break;
        case 2: _t->HumidityLabelUpdated(); break;
        case 3: _t->TimeLabelUpdated(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::TemperatureLabelUpdated)) {
                *result = 0;
            }
        }
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::PressureLabelUpdated)) {
                *result = 1;
            }
        }
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::HumidityLabelUpdated)) {
                *result = 2;
            }
        }
        {
            typedef void (GuiPainter::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&GuiPainter::TimeLabelUpdated)) {
                *result = 3;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        GuiPainter *_t = static_cast<GuiPainter *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->GetTemperature(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->GetPressure(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->GetHumidity(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->GetCurrentTime(); break;
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
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
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
void GuiPainter::TemperatureLabelUpdated()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}

// SIGNAL 1
void GuiPainter::PressureLabelUpdated()
{
    QMetaObject::activate(this, &staticMetaObject, 1, Q_NULLPTR);
}

// SIGNAL 2
void GuiPainter::HumidityLabelUpdated()
{
    QMetaObject::activate(this, &staticMetaObject, 2, Q_NULLPTR);
}

// SIGNAL 3
void GuiPainter::TimeLabelUpdated()
{
    QMetaObject::activate(this, &staticMetaObject, 3, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
