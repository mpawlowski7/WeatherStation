import weatherstation.gui 1.0

import QtQuick 2.5
import QtGraphicalEffects 1.0

Column {
    id: inside
    width: parent.width
    height: parent.height
    anchors.centerIn: parent
    anchors.margins: 20
    spacing: 10

    Item {
        width: parent.width
        height: parent.height * 0.03
    }

    Rectangle {
        id: inside_ico_container
        width: parent.width * 0.5
        height: parent.width * 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 180

        Image {
            sourceSize: Qt.size(parent.height*0.9, parent.height*0.9)
            id: inside_ico
            source: "img/home.svg"
            smooth: true
            anchors.centerIn: inside_ico_container
            anchors.verticalCenter: parent.verticalCenter

        }
    }

    Item {
        width: parent.width
        height: parent.height * 0.42
        anchors.horizontalCenter: parent.horizontalCenter

        TextShadow { id: temperature_txt;
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -20
            anchors.verticalCenter: parent.verticalCenter
            text: GuiPainter.temperature; size: 64
        }
        TextShadow { id: temperature_txt_unit; anchors.left: temperature_txt.right;  anchors.baseline: temperature_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 32 }
    }

    Rectangle {
        width: parent.width * 1.05
        height: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#9d415c"

        Item{
            width: parent.width * 0.35
            height: parent.width * 0.35
            anchors.verticalCenter: parent.verticalCenter;

            Image {
                sourceSize: Qt.size(parent.height*0.35, parent.height*0.35)
                id: humidityIn_ico
                source: "img/humidity_out.svg"
                anchors.centerIn: parent
                visible: false
            }

            DropShadow {
                source: humidityIn_ico
                horizontalOffset: 1
                verticalOffset: 1
                radius: 1
                samples: 4
                color: "#000000"
                anchors.fill: source
            }
        }

        TextShadow { id: humidity_txt;  anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.humidity + qsTr("%"); size: 20 }
    }

}
