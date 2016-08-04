import QtQuick 2.2
import weatherstation.gui 1.0
import weatherstation.led 1.0

import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

Window {
    id: root
    title: qsTr("Weather Station")
    visible: true
    width: 800
    height: 480
    contentOrientation: Qt.LandscapeOrientation

    Component.onCompleted: {
        GuiPainter.startReadingData();
    }

    FontLoader { id: ubuntuFont; source: "fonts/Ubuntu-R.ttf" }

    Image {
       id: back_img
       source: "img/back.jpg"
    }

    Rectangle {
        id: background
        anchors.right: parent.right
        width: 560; height: 480

        color: 'skyblue'
        opacity: 1
        layer.enabled: true

        layer.effect: DropShadow {
            horizontalOffset: -20
            verticalOffset: 0
//            radius: 4
//            samples: 8
//            color: 'black'
        }
    }


    Item {
        id: foreground
        width: parent.width
        height: parent.height
        Layout.fillWidth: true
        Layout.fillHeight: true
   //     color: 'transparent'

        Drawer {
            id: drawer
            position: Qt.RightEdge
            visualParent: foreground
            color: 'darkslategray'

            Column {
                anchors.top: parent.top
                anchors.centerIn: parent
                width: parent.width; height: parent.height
                spacing: 10


                Item {
                    id: label
                    width: drawer.width
                    height: 80

                    TextShadow {
                        anchors.centerIn: parent; anchors.margins: 5
                        font.family: ubuntuFont.name; text: qsTr("Led Painter"); size: 40; shadowColor: 'black'
                    }
                }

                Item {
                    id: matrix
                    width: parent.width - 40
                    height: 220
                    anchors.horizontalCenter: label.horizontalCenter

                    LedMatrix {
                        width: parent.width
                    }
                }

                Rectangle {
                    id: btn_rainbow
                    width: parent.width - 20
                    height: 40
                    color: 'transparent'
                    border.color: 'white'
                    border.width: 2
                    radius: 10
                    anchors.horizontalCenter: label.horizontalCenter

                    TextShadow {
                        anchors.centerIn: parent; anchors.margins: 5
                        text: qsTr("Rainbow"); size: 20; shadowColor: 'black'
                    }
                }

                Rectangle {
                    id: btn_random
                    width: parent.width - 20
                    height: 40
                    color: 'transparent'
                    border.color: 'white'
                    border.width: 2
                    radius: 10
                    anchors.horizontalCenter: label.horizontalCenter

                    TextShadow {
                        anchors.centerIn: parent; anchors.margins: 5
                        text: qsTr("Random"); size: 20; shadowColor: 'black'
                    }
                }

                Rectangle {
                    id: btn_clear
                    width: parent.width - 20
                    height: 40
                    color: 'transparent'
                    border.color: 'white'
                    border.width: 2
                    radius: 10
                    anchors.horizontalCenter: label.horizontalCenter

                    TextShadow {
                        anchors.centerIn: parent; anchors.margins: 5
                        text: qsTr("Clear"); size: 20; shadowColor: 'black'
                    }
                }

            }
        }

        RowLayout {
            id: mainLayout
            width: 800
            height: 480
            spacing: 10
         //   anchors.margins: 10
            anchors.centerIn: parent

            Rectangle {
                id: col1_back; color: 'slategray'; opacity: 1;
                width: 260
                height: 480
        //        anchors.left: left_col.left;
                anchors.right: left_col.right
                Rectangle { id: col1_back_border1; width: 2; height: 480; anchors.left: col1_back.right; color: 'powderblue'; }
           //     Rectangle { id: col1_back_border3; width: 2; height: 480; anchors.left: col1_back_border2.right; color: 'aliceblue'; opacity: 1; }
            }



            Column {
                id: left_col
                width: 240
                height: 480
      //          Layout.fillWidth: true;
     //           Layout.fillHeight: true;
         //       Layout.alignment: Qt.AlignRight

          //      anchors.bottom: parent.bottom
           //     anchors.bottomMargin: 20
                anchors.left: parent.left
                spacing: 24

                Item{
                    width: 64
                    height: 96
                    anchors.horizontalCenter: left_col.horizontalCenter

                    Image {
                        id: home_ico
                        source: "img/inside_icon.png"
                        visible: false
                    }

                    DropShadow {
                        source: home_ico
                        horizontalOffset: 2
                        verticalOffset: 2
                        radius: 0
                        samples: 0
                        color: 'slategray'
                        anchors.fill: source
                    }
                }


                Item{
                    width: 240
                    height: 64
                    anchors.horizontalCenter: left_col.horizontalCenter

                        Image {
                            id: temp_ico
                            source: "img/measurement-units-temperature-icon.png"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left; anchors.leftMargin: 24
                            visible: false
                        }

                        DropShadow {
                            source: temp_ico
                            horizontalOffset: 2
                            verticalOffset: 2
                            radius: 0
                            samples: 0
                            color: 'slategray'
                            anchors.fill: source
                        }

                        TextShadow { id: temperature_txt; anchors.left: temp_ico.right; anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.temperature; size: 48 }
                        TextShadow { anchors.baseline: temperature_txt.baseline; anchors.left: temperature_txt.right; anchors.leftMargin: 5; text: qsTr(" \u00B0")+qsTr("C"); size: 32 }
                    }

                Item{
                    width: 240
                    height: 64
                    anchors.horizontalCenter: left_col.horizontalCenter

                        Image {
                            id: pressure_ico
                            source: "img/measurement-units-pressure-icon.png"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left; anchors.leftMargin: 24
                            visible: false
                        }

                        DropShadow {
                            source: pressure_ico
                            horizontalOffset: 2
                            verticalOffset: 2
                            radius: 0
                            samples: 0
                            color: 'slategray'
                            anchors.fill: source
                        }

                        TextShadow { id: pressure_txt; anchors.left: pressure_ico.right; anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.pressure; size: 48 }
                        TextShadow { anchors.baseline: pressure_txt.baseline; anchors.left: pressure_txt.right; anchors.leftMargin: 5; text: qsTr(" Pa"); size: 32 }
                    }

                Item{
                    width: 240
                    height: 64
                    anchors.horizontalCenter: left_col.horizontalCenter

                        Image {
                            id: humidity_ico
                            source: "img/measurement-units-humidity-icon.png"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left; anchors.leftMargin: 24
                            visible: false
                        }

                        DropShadow {
                            source: humidity_ico
                            horizontalOffset: 2
                            verticalOffset: 2
                            radius: 0
                            samples: 0
                            color: 'slategray'
                            anchors.fill: source
                        }

                        TextShadow { id: humidity_txt; anchors.left: humidity_ico.right; anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.humidity; size: 48 }
                        TextShadow { anchors.baseline: humidity_txt.baseline; anchors.left: humidity_txt.right; anchors.leftMargin: 5; text: qsTr(" %rH"); size: 32 }

                    }
                }

            Column {
                id: right_col
                width: 560
                height: 480;
                spacing: 2

                Item{
                    width: 128
                    height: 160
                    anchors.horizontalCenter: right_col.horizontalCenter

                    Image {
                        id: sunny_ico
                        source: "img/sunny_icon.png"
                        visible: false
                    }

                    DropShadow {
                        source: sunny_ico
                        horizontalOffset: 2
                        verticalOffset: 2
                        radius: 0
                        samples: 0
                        color: 'slategray'
                        anchors.fill: source
                    }
                }


                Item {
              //      Layout.alignment: Qt.AlignRight
                    width: location_txt.width+10
                    height: 32
                    TextShadow { id: location_txt; text: "Rzeszów"; size: 32 }
                }
                Item {
               //     Layout.alignment: Qt.AlignHCenter
                    width: time_txt.width+10
                    height: 128
                    TextShadow { id: time_txt; anchors.margins: 5; text: GuiPainter.currentTime; size: 96 }
                }

            }

       }
    }
}
