import QtQuick 2.0

Item {
    id: root

    property string day: new Date().toLocaleDateString(Qt.locale(), "dd.MM")
    property string icon: "clear"
    property string condition: "clear"
    property string tempHigh: "30.0"
    property string tempLow: "15.0"

    TextShadow {
        id: day_txt
        text: root.day
        size: 12
        textColor: "#ffffff"
        shadowVisible: false
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    Row {
        id: weather_status
        width: parent.width
        height: parent.height * 1.1
        spacing: 15
        anchors.left: parent.left
        anchors.leftMargin: 25

        WeatherIcon {
            type: icon
            anchors.verticalCenter: parent.verticalCenter
            color: "#1bbbe4"
            size: 22
        }

        TextShadow {
            id: tempHigh
            text: root.tempHigh + qsTr("\u00B0")
            size: 24
            textColor: "#ffffff"
            shadowVisible: false
            anchors.verticalCenter: parent.verticalCenter
        }

        TextShadow {
            id: tempLow
            text: root.tempLow + qsTr("\u00B0")
            size: 16
            textColor: "#00c7b3"
            shadowVisible: false
            anchors.baseline: tempHigh.baseline
        }
    }
}
