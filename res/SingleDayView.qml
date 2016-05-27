import QtQuick 2.0
import QtGraphicalEffects 1.0


Column {
    id: root

    property string day: currentDate.toLocaleDateString(Qt.locale("pl_PL"), "dd/MM")
    property string icon: "clear"
    property string condition: "clear"
    property string tempHigh: "30.0"
    property string tempLow: "15.0"

    spacing: 20
    anchors.topMargin: 20

    TextShadow { width: parent.width; id: date_txt; text: day; size: 14 }

    Item {
        width: parent.width
        height: parent.height * 0.15
//        anchors.bottom: weather_ico_container.top
        TextShadow { id: forecast_txt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -10
            anchors.verticalCenter: parent.verticalCenter
            text: tempHigh + " | " + tempLow; size: 32 }
        TextShadow { id: forecast_txt_unit; anchors.left: forecast_txt.right; anchors.baseline: forecast_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 14 }
    }

    Rectangle{
        id: weather_ico_container
        width: parent.width
        height: parent.height * 0.3
        color: "transparent"
        radius: 180
  //      anchors.centerIn: parent

        Image {
            sourceSize: Qt.size(parent.width, parent.width)
            id: weather_ico
            source: "img/"+icon+".svg"
            smooth: true
            visible: false
            anchors.centerIn: weather_ico_container
        }

        DropShadow {
            source: weather_ico
            horizontalOffset: 1
            verticalOffset: 1
            radius: 1
            samples: 4
            color: 'slategray'
            opacity: 1
            anchors.fill: source
        }
    }

    Item {
        width: parent.width
        height: parent.height * 0.15
//        anchors.top: weather_ico_container.bottom
        TextShadow { id: cond_txt; anchors.centerIn: parent;  text: condition; size: 24 }
    }
}
