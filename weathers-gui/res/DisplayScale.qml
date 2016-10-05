import QtQuick 2.0
import QtQuick.Window 2.0

Item {
    id: root

    readonly property real refWidth: 800
    readonly property real refHeight: 480
    readonly property real refDpi: 162.121

//    property real _scale: 1.0


    function font() {
        _width = Screen.width;
        _height = Screen.height;
        _dpi = Screen.logicalPixelDensity * 25.4;
        return Math.min(_height*refDpi/(_dpi*refHeight), _width*refDpi/(_dpi*refWidth));
   //     return _scale
    }

}
