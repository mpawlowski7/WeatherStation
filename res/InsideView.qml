import weatherstation.gui 1.0

import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: parent.width * 0.35
    height: parent.height
    anchors.verticalCenter: parent.verticalCenter
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#54606c" }
        GradientStop { position: 1.0; color: "#54606c" }
    }


    Column {
        id: wrapper
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        anchors.margins: 20
        spacing: 10

        Item {
            width: parent.width
            height: parent.height * 0.03
        }

//        Rectangle {
//            id: inside_ico_container
//            width: parent.width * 0.5
//            height: parent.width * 0.5
//            anchors.horizontalCenter: parent.horizontalCenter
//            radius: 180

//            Image {
//                sourceSize: Qt.size(parent.height*0.9, parent.height*0.9)
//                id: inside_ico
//                source: "img/home.svg"
//                smooth: true
//                anchors.centerIn: inside_ico_container
//                anchors.verticalCenter: parent.verticalCenter

//            }
//        }
       TextShadow { id: label; text: GuiPainter.currentDateTime["time"]; size: 56 }
        Item {
            width: parent.width
            height: parent.height * 0.475
            anchors.horizontalCenter: parent.horizontalCenter

            TextShadow { id: temperature_txt;
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -10
                anchors.verticalCenter: parent.verticalCenter
                text: GuiPainter.temperature; size: 48
                textColor: "#ffa009"
            }
            TextShadow { id: temperature_txt_unit; textColor: "#ffa009"; anchors.left: temperature_txt.right;  anchors.baseline: temperature_txt.baseline; text: qsTr("\u00B0"); size: 24 }
        }

        Rectangle {
            width: parent.width
            height: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#708090"

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

            TextShadow { id: humidity_txt;  anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.humidity + qsTr("%"); size: 16 }
        }

    }
}
