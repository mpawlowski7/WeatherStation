import weatherstation.gui 1.0

import QtQuick 2.5
import QtGraphicalEffects 1.0

Column {
    id: outside
    width: parent.width
    height: parent.height
    anchors.centerIn: parent
    anchors.margins: 20
    spacing: 5

    Item {
        width: parent.width
        height: parent.height * 0.05
    }

    Rectangle {
        id: outside_ico_container
        width: parent.width * 0.5
        height: parent.width * 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 180

        Image {
            sourceSize: Qt.size(parent.height*0.9, parent.height*0.9)
            id: outside_ico
            source: "img/hills.svg"
            smooth: true
            anchors.centerIn: outside_ico_container
            anchors.verticalCenter: parent.verticalCenter

        }

    }

    Item{
        width: parent.width
        height: parent.height * 0.26
        anchors.horizontalCenter: parent.horizontalCenter

        TextShadow { id: temperatureOut_txt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -10
            anchors.verticalCenter: parent.verticalCenter
            text: GuiPainter.feelslikeOut; size: 38 }
        TextShadow { id: temperatureOut_txt_unit; anchors.left: temperatureOut_txt.right; anchors.baseline: temperatureOut_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 20 }
    }

    Rectangle {
        id: right_col_GR
        width: parent.width * 1.05
        height: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        Item {
            id: wind_dir_container
            width: parent.width * 0.35
            height: parent.width * 0.35
            rotation: GuiPainter.windDirOut - 45.0
            anchors.verticalCenter: parent.verticalCenter

            Image {
                sourceSize: Qt.size(parent.height*0.35, parent.height*0.35)
                id: wind_dir_ico
                source: "img/compass.svg"
                smooth: true
                visible: false
                anchors.centerIn: wind_dir_container
                anchors.verticalCenter: parent.verticalCenter
            }

            DropShadow {
                source: wind_dir_ico
                horizontalOffset: 1
                verticalOffset: 1
                radius: 1
                samples: 4
                color: 'slategray'
                anchors.fill: source
            }
        }
        TextShadow { id: windOut_txt; text: GuiPainter.windSpeedOut+qsTr(" km/h"); size: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        width: parent.width * 1.05
        height: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        color: right_col_GR.color

        Item{
            width: parent.width * 0.35
            height: parent.width * 0.35
            anchors.verticalCenter: parent.verticalCenter;

            Image {
                sourceSize: Qt.size(parent.height*0.35, parent.height*0.35)
                id: pressure_ico
                source: "img/pressure.svg"
                anchors.centerIn: parent
                visible: false
            }

            DropShadow {
                source: pressure_ico
                horizontalOffset: 1
                verticalOffset: 1
                radius: 1
                samples: 4
                color: 'slategray'
                anchors.fill: source
            }
        }

        TextShadow { id: pressure_txt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: GuiPainter.pressure+qsTr(" hPa"); size: 20 }

    }


    Rectangle {
        width: parent.width * 1.05
        height: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        color: right_col_GR.color

        Item{
            width: parent.width * 0.35
            height: parent.width * 0.35
            anchors.verticalCenter: parent.verticalCenter;

            Image {
                sourceSize: Qt.size(parent.height*0.35, parent.height*0.35)
                id: humidityOut_ico
                source: "img/humidity_out.svg"
                anchors.centerIn: parent
                visible: false
            }

            DropShadow {
                source: humidityOut_ico
                horizontalOffset: 1
                verticalOffset: 1
                radius: 1
                samples: 4
                color: 'slategray'
                anchors.fill: source
            }
        }

        TextShadow { id: humidityOut_txt;
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.humidityOut; size: 20 }

    }

}
