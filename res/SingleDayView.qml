import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property string day: new Date().toLocaleDateString(Qt.locale("pl_PL"), "dd.MM")
    property string icon: "clear"
    property string condition: "clear"
    property string tempHigh: "30.0"
    property string tempLow: "15.0"

    TextShadow {
        id: day_txt
        text: root.day
        size: 14
//        anchors.bottom: weather_status.top
    }

    Row {
        id: weather_status
        width: parent.width
        height: parent.height
        spacing: 0

        WeatherIcon {
            type: icon
            anchors.verticalCenter: parent.verticalCenter
        }

        Item {
            width: parent.width * 0.6
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            TextShadow { id: forecast_txt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -10
                anchors.verticalCenter: parent.verticalCenter
                text: tempLow != "" ? root.tempLow + " | " + root.tempHigh : root.tempHigh; size: 24 }
            TextShadow { id: forecast_txt_unit; anchors.left: forecast_txt.right; anchors.baseline: forecast_txt.baseline; text: qsTr("\u00B0"); size: 16 }
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height * 0.02
        anchors.bottom: parent.bottom
        color: "white"
        opacity: 0.3
    }
}
