import QtQuick 2.0

Text {
    id: shadow
    FontLoader { id: ubuntuFont; source: "fonts/Ubuntu-R.ttf" }
    property alias text: shadow.text
    property alias size: shadow.font.pixelSize
    property string shadowColor: shadow.color

    font.family: ubuntuFont.name
    font.pointSize: 15
    text: qsTr("Empty")
    color: 'slategray'
    clip: true

    Text {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 2
        id: main
        font: parent.font
        text: parent.text
        color: 'white'
  //      x: parent.x-1
  //      y: parent.y-2
    }
}
