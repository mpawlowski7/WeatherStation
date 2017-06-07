import QtQuick 2.5
import QtQuick.Window 2.0

Item {
    id: root
    property var icons: {
        "chanceflurries" : "\uf064",
                "chancerain" : "\uf009",
                "chancesleat" : "\uf0b2",
                "chancesnow" : "\uf00a",
                "chancetstorms" : "\uf00e",
                "clear" : "\uf00d",
                "cloudy" : "\uf013",
                "flurries" : "\uf064",
                "hazy" : "\uf0b6",
                "mostlycloudy" : "\uf002",
                "mostlysunny" : "\uf00c",
                "partlycloudy" : "\uf002",
                "partlysunny" : "\uf07d",
                "rain" : "\uf01a",
                "sleat" : "\uf0b5",
                "snow" : "\uf01b",
                "sunny" : "\uf00d",
                "tstorms" : "\uf01d",
                "unknown" : "\uf00d",
                "humidity" : "\uf078",
                "pressure" : "\uf079",
                "wind" : "\uf0b1"
    }
    property string type: "unknown"
    property real size: 24
    property string color: "white"

    readonly property real refWidth: 800
    readonly property real refHeight: 480
    readonly property real refDpi: 162.121
    readonly property real _width: Screen.width;
    readonly property real _height: Screen.height;
    readonly property real _dpi: Screen.logicalPixelDensity * 25.4;

    property real _scale: Math.min(_height*refDpi/(_dpi*refHeight), _width*refDpi/(_dpi*refWidth))

    width: main.width
    height: main.height
    clip: false

    FontLoader { id: weatherIcons; source: "fonts/weathericons-regular-webfont.ttf" }
    Text {
        id: main
        font.family: weatherIcons.name
        font.pointSize: root.size * _scale
        color: root.color
        text: root.icons[root.type]
        anchors.centerIn: root
        renderType: Text.NativeRendering
    }
}
