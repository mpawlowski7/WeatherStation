import QtQuick 2.5

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
        "unknown" : "\uf00d"
    }
    property string type: "unknown"
    property int size: 24
    property string color: "white"
    width: main.width
    height: main.height
    clip: false

    FontLoader { id: weatherIcons; source: "fonts/weathericons-regular-webfont.ttf" }
    Text {
        id: main
        font.family: weatherIcons.name
        font.pointSize: root.size
        color: root.color
        text: root.icons[root.type]
        anchors.centerIn: root
        renderType: Text.NativeRendering
    }

    Text {
        id: shadow
        z: main.z - 1
        //visible: shadowVisible
        font: main.font
        text: main.text
        anchors.centerIn: main
        anchors.verticalCenter: main.verticalCenter
        anchors.verticalCenterOffset: 2
        anchors.horizontalCenter: main.horizontalCenter
        anchors.horizontalCenterOffset: 2
        color: "#000000"
        opacity: 0.3
        renderType: Text.NativeRendering
    }


}
