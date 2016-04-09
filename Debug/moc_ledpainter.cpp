/****************************************************************************
** Meta object code from reading C++ file 'ledpainter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../gui/ledpainter.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ledpainter.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_LedPainter_t {
    QByteArrayData data[9];
    char stringdata0[68];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_LedPainter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_LedPainter_t qt_meta_stringdata_LedPainter = {
    {
QT_MOC_LITERAL(0, 0, 10), // "LedPainter"
QT_MOC_LITERAL(1, 11, 9), // "drawPixel"
QT_MOC_LITERAL(2, 21, 0), // ""
QT_MOC_LITERAL(3, 22, 5), // "color"
QT_MOC_LITERAL(4, 28, 2), // "px"
QT_MOC_LITERAL(5, 31, 8), // "activate"
QT_MOC_LITERAL(6, 40, 10), // "deactivate"
QT_MOC_LITERAL(7, 51, 5), // "clear"
QT_MOC_LITERAL(8, 57, 10) // "randomness"

    },
    "LedPainter\0drawPixel\0\0color\0px\0activate\0"
    "deactivate\0clear\0randomness"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_LedPainter[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    2,   39,    2, 0x0a /* Public */,
       5,    0,   44,    2, 0x0a /* Public */,
       6,    0,   45,    2, 0x0a /* Public */,
       7,    0,   46,    2, 0x0a /* Public */,
       8,    0,   47,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void, QMetaType::QColor, QMetaType::QPoint,    3,    4,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void LedPainter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        LedPainter *_t = static_cast<LedPainter *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->drawPixel((*reinterpret_cast< QColor(*)>(_a[1])),(*reinterpret_cast< QPoint(*)>(_a[2]))); break;
        case 1: _t->activate(); break;
        case 2: _t->deactivate(); break;
        case 3: _t->clear(); break;
        case 4: _t->randomness(); break;
        default: ;
        }
    }
}

const QMetaObject LedPainter::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_LedPainter.data,
      qt_meta_data_LedPainter,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *LedPainter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LedPainter::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_LedPainter.stringdata0))
        return static_cast<void*>(const_cast< LedPainter*>(this));
    return QObject::qt_metacast(_clname);
}

int LedPainter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
