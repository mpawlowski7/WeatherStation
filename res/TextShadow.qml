import QtQuick 2.5

Item {
    property alias text: main.text
    property alias size: main.font.pointSize
    property alias shadowColor: shadow.color
    property alias textColor: main.color
    property bool shadowVisible: true

    FontLoader { id: ubuntuFont; source: "fonts/WireOne.ttf" }

    width: main.width
    height: main.height

    Text {
        id: main
        anchors.centerIn: parent
        font.family: ubuntuFont.name
        font.bold: true
        color: '#f6f6f6'
    }

    Text {
        id: shadow
        z: main.z - 1
        visible: shadowVisible
        font: main.font
        text: main.text
        anchors.centerIn: main

        anchors.verticalCenter: main.verticalCenter
        anchors.verticalCenterOffset: 2
        anchors.horizontalCenter: main.horizontalCenter
        anchors.horizontalCenterOffset: 2

    //    font.pointSize: 15
     //   font.bold: true
        color: "#000000"
        opacity: 0.3
   }

}
