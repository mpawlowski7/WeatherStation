import QtQuick 2.5
import QtQuick.Window 2.0

Item {
    property alias text: main.text
    property real size: 12
    property alias shadowColor: shadow.color
    property alias textColor: main.color
    property bool shadowVisible: true

    readonly property real refWidth: 800
    readonly property real refHeight: 480
    readonly property real refDpi: 162.121
    readonly property real _width: Screen.width;
    readonly property real _height: Screen.height;
    readonly property real _dpi: Screen.logicalPixelDensity * 25.4;

    property real _scale: Math.min(_height*refDpi/(_dpi*refHeight), _width*refDpi/(_dpi*refWidth))

    FontLoader { id: ubuntuFont; source: "fonts/Ubuntu-C.ttf" }

    width: main.width
    height: main.height

    Text {
        id: main
        anchors.centerIn: parent
        font.pointSize: size * /*Math.min(Screen.height * 162.121 / (Screen.logicalPixelDensity * 25.4 * 480),
                                        Screen.width * 162.121 / (Screen.logicalPixelDensity * 25.4 * 800))*/ _scale
        font.family: ubuntuFont.name
        font.bold: false
        color: '#f6f6f6'


//        wrapMode: Text.WordWrap
//        width: parent.width * 0.2l

    }

    Text {
        id: shadow
//        z: main.z - 1
//        visible: shadowVisible
//        font: main.font
//        text: main.text
//        anchors.centerIn: main
////        wrapMode: Text.WordWrap
////        width: parent.width * 0.2l

//        anchors.verticalCenter: main.verticalCenter
//        anchors.verticalCenterOffset: 2
//        anchors.horizontalCenter: main.horizontalCenter
//        anchors.horizontalCenterOffset: 2

//        //    font.pointSize: 15
//        //   font.bold: true
//        color: "#000000"
//        opacity: 1
    }

}
