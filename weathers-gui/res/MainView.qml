import weatherstation.gui 1.0

import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1

import "controls" as Awesome

Window {
    id: root
    title: qsTr("Weather Station")

    FontAwesome {
        id: awesome
        resource: "qrc:///res/fonts/fontawesome-webfont.ttf"
    }

    Rectangle {
        id: main_container
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.margins: 0
        color: "#32343c"

        Rectangle {
            visible: false
            id: bottom_bar
            width: root.width; height: root.height * 0.05;
            anchors.top: main_container.top
            color: "#000000"

            Item {
                id: bottom_bar_container
                anchors.fill: parent

                TextShadow {
                    id: time_txt
                    text: awesome.icons.fa_plug + " " + awesome.icons.fa_battery_full + " " + awesome.icons.fa_wifi + "    " + awesome.icons.fa_ellipsis_v
                    textColor: "#ffffff"
                    anchors.right: parent.right
                    anchors.rightMargin: parent.height * 0.5
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextShadow {
                    id: location_txt;
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: parent.height * 0.5
                    text: awesome.icons.fa_map_marker + " " + GuiPainter.currentWeather["location"]
                    textColor: '#ffffff'
                }
            }
        }

        RowLayout {
            id: main_row
            anchors.fill: parent
            anchors.centerIn: parent
            anchors.margins: parent.width * 0.01
            spacing: parent.width * 0.01

            InsideView {
                objectName: "inside_view"
                Layout.preferredWidth: parent.width * 0.33 - parent.width * 0.01 / 2
                Layout.preferredHeight: parent.height
                Layout.fillHeight: true
            }

            OutsideView {
                objectName: "outside_view"
                Layout.preferredWidth: parent.width * 0.33 - parent.width * 0.01 / 2
                Layout.preferredHeight: parent.height
                Layout.fillHeight: true
            }

            ForecastView {
                objectName: "forecast_view"
                Layout.preferredWidth: parent.width * 0.33 - parent.width * 0.01 / 2
                Layout.preferredHeight: parent.height
                Layout.fillHeight: true
            }
        }

    }

//    Item {
//        id: drawer_container
//        anchors.fill: parent
//        Drawer {
//            id: drawer
//            position: Qt.RightEdge
//            visualParent: drawer_container
//            //color: 'slategray'

//            Column {
//                anchors.top: parent.top
//                anchors.centerIn: parent
//                width: parent.width; height: parent.height
//                spacing: 10


//                Item {
//                    id: label
//                    width: drawer.width
//                    height: 80

//                    TextShadow {
//                        anchors.centerIn: parent; anchors.margins: 5
//                        text: qsTr("Ustawienia"); size: 24; shadowColor: 'black'
//                    }
//                }

//                Item {
//                    id: matrix
//                    width: parent.width - 40
//                    height: 220
//                    anchors.horizontalCenter: label.horizontalCenter

//                    LedMatrix {
//                        width: parent.width
//                    }
//                }

//                Rectangle {
//                    id: btn_rainbow
//                    width: parent.width - 20
//                    height: 40
//                    color: 'transparent'
//                    border.color: 'white'
//                    border.width: 2
//                    radius: 10
//                    anchors.horizontalCenter: label.horizontalCenter

//                    TextShadow {
//                        anchors.centerIn: parent; anchors.margins: 5
//                        text: qsTr("Rainbow"); size: 12; shadowColor: 'black'
//                    }

//                }

//                Rectangle {
//                    id: btn_random
//                    width: parent.width - 20
//                    height: 40
//                    color: 'transparent'
//                    border.color: 'white'
//                    border.width: 2
//                    radius: 10
//                    anchors.horizontalCenter: label.horizontalCenter

//                    property bool isOn: false

//                    TextShadow {
//                        anchors.centerIn: parent; anchors.margins: 5
//                        text: qsTr("Random"); size: 12; shadowColor: 'black'
//                    }

//                    MouseArea {
//                        id: btn_random_ma
//                        anchors.fill: parent
//                        onClicked: {}
////                        {
////                            if(btn_random.isOn)
////                            {
////                                LedPainter.deactivate();
////                                btn_random.isOn = false;
////                            }
////                            else
////                            {
////                                LedPainter.activate();
////                                btn_random.isOn = true;
////                            }
////                        }
//                    }
//                }

//                Rectangle {
//                    id: btn_clear
//                    width: parent.width - 20
//                    height: 40
//                    color: 'transparent'
//                    border.color: 'white'
//                    border.width: 2
//                    radius: 10
//                    anchors.horizontalCenter: label.horizontalCenter

//                    TextShadow {
//                        anchors.centerIn: parent; anchors.margins: 5
//                        text: qsTr("Clear"); size: 12; shadowColor: 'black'
//                    }

//                    MouseArea {
//                        id: btn_clear_ma
//                        anchors.fill: parent
//                   //     onClicked: LedPainter.clear();
//                    }
//                }

//            }

//        }
//    }

}
