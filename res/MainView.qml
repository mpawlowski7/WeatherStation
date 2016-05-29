import weatherstation.gui 1.0
import weatherstation.led 1.0

import QtQuick 2.5
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
// import "jbQuick/charts/QChart.qml"

Window {
    id: root
    title: qsTr("Weather Station")
    visible: true
    width: 800
    height: 480
    maximumWidth: 1920
    maximumHeight: 1080
    minimumWidth: 800
    minimumHeight: 480
    contentOrientation: Qt.LandscapeOrientation
    modality: Qt.ApplicationModal

    Component.onCompleted: {
        console.log("Window size:"+root.width+" "+root.height)
        console.log("Start reading stuff")
    }

    FontLoader { id: ubuntuFont; source: "fonts/Ubuntu-L.ttf" }

    Column {
        id: main_container
        anchors.fill: parent
        spacing: 0

        Row {
            id: main_row
            width: parent.width
            height: parent.height * 0.9
            anchors.bottom: root.bottom
            spacing: 0
            Component.onCompleted: {
                console.log("GridLayout: "+main_row.width+" "+main_row.height)
            }

            ForecastView { objectName: "forecast_view" }
            InsideView { objectName: "inside_view" }
            OutsideView { objectName: "outside_view" }

        }

        Rectangle {
            id: bottom_bar
            width: root.width; height: root.height * 0.1;
            color: '#5E2750'

            Item {
                id: bottom_bar_container
                anchors.fill: parent

                Text { id: date_txt
                    text: GuiPainter.currentDateTime["date"]
                    font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12; font.bold: true
                    anchors.centerIn: parent
                }
                Text { id: time_txt
                    text: GuiPainter.currentDateTime["time"]
                    font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12; font.bold: true
                    anchors.right: parent.right
                    anchors.rightMargin: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text { id: location_txt;
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: parent.height; text: GuiPainter.currentWeather["location"]; font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12; font.bold: true }
            }
        }

    }

    Item {
        id: drawer_container
        anchors.fill: parent
        Drawer {
            id: drawer
            position: Qt.RightEdge
            visualParent: drawer_container
            color: 'slategray'

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
                        text: qsTr("Led Painter"); size: 24; shadowColor: 'black'
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
                        text: qsTr("Rainbow"); size: 12; shadowColor: 'black'
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

                    property bool isOn: false

                    TextShadow {
                        anchors.centerIn: parent; anchors.margins: 5
                        text: qsTr("Random"); size: 12; shadowColor: 'black'
                    }

                    MouseArea {
                        id: btn_random_ma
                        anchors.fill: parent
                        onClicked:
                        {
                            if(btn_random.isOn)
                            {
                                LedPainter.deactivate();
                                btn_random.isOn = false;
                            }
                            else
                            {
                                LedPainter.activate();
                                btn_random.isOn = true;
                            }
                        }
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
                        text: qsTr("Clear"); size: 12; shadowColor: 'black'
                    }

                    MouseArea {
                        id: btn_clear_ma
                        anchors.fill: parent
                        onClicked: LedPainter.clear();
                    }
                }

            }

        }
    }

}
