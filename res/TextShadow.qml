import QtQuick 2.0

Text {
    id: shadow
    FontLoader { id: ubuntuFont; source: "fonts/WireOne.ttf" }
    property alias text: shadow.text
    property alias size: shadow.font.pointSize
    property string shadowColor: shadow.color

    font.family: ubuntuFont.name
    font.bold: true
//    font.pointSize: 15
 //   font.bold: true
    text: qsTr("Empty")
    color: 'slategray'
    clip: true

    Text {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 1
        id: main
        font: parent.font
        text: parent.text
        color: '#f6f6f6'
    }
}
