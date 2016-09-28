import QtQuick 2.0

Item {
    id: root

    property string day: "---"
    property string icon: "clear"
    property string condition: "clear"
    property string tempHigh: "-.-"
    property string tempLow: "-.-"
    Item {
        width: parent.width
        anchors.left: parent.left
        anchors.leftMargin: width * 0.1
        TextShadow {
            id: day_txt
            text: root.day
            size: 12
            textColor: "#ffffff"
            shadowVisible: false
        }
    }

    Row {
        id: weather_status
        height: parent.height * 1.1
        spacing: height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter

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
