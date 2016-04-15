import QtQuick 2.5
import weatherstation.gui 1.0
import weatherstation.led 1.0

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


    property date currentDate: new Date()

    Component.onCompleted: {
        console.log("Window size:"+root.width+" "+root.height)
        console.log("Start reading stuff")
        GuiPainter.startReadingData();
    }

    FontLoader { id: ubuntuFont; source: "fonts/Ubuntu-L.ttf" }

    Column {
        id: main_container
        anchors.fill: parent
        Rectangle {
            id: top_bar
            width: root.width; height: root.height * 0.08;
            color: '#000000'

            Text { id: time_txt; font.family: ubuntuFont.name; color: '#ffffff'; anchors.right: date_txt.left; anchors.rightMargin: 10; text: GuiPainter.currentTime; font.pointSize: 12 }
            Text { id: date_txt; font.family: ubuntuFont.name; color: '#ffffff'; anchors.horizontalCenter: top_bar.horizontalCenter; anchors.right: top_bar.right; anchors.rightMargin: 10; text: currentDate.toLocaleDateString(); font.pointSize: 12 }
       }



    //        layer.enabled: true

    //        layer.effect: DropShadow {
    //            horizontalOffset: -(background.width * 0.01)
    //            verticalOffset: 0
    //            radius: 4
    //            samples: 8
    //            color: 'gray'
    //        }
    //    Image {
    //       id: back_img
    //       anchors.fill: background
    //       source: "img/back.jpg"
    //    }



    //    Item {
    //        id: wrapper
    //        width: root.width
    //        height: root.height
    //        Component.onCompleted: {
    //            console.log("Wrapper size:"+wrapper.width+" "+wrapper.height)
    //        }
       //     color: 'transparent'


       //     }

            Row {
                id: main_row
         //       Layout.fillWidth: true
          //      Layout.fillHeight: true
                width: parent.width
                height: parent.height * 0.92
                anchors.bottom: root.bottom
         //       anchors.fill: parent
                spacing: 0

    //            columnSpacing: 0
    //            rowSpacing: 0
    //            columns: 2
        //        rows: 2
         //       anchors.centerIn: parent
                Component.onCompleted: {
                    console.log("GridLayout: "+main_row.width+" "+main_row.height)
                }

                Rectangle {
                    id: left_col
                    width: main_row.width * 0.3
                    height: main_row.height
                    color: '#00ade7'


                Column {
                    id: left_col_inside
          //          width: left_col.width
         //           height: left_col.height
                    anchors.centerIn: parent
               //     Layout.alignment: Qt.AlignVCenter

              //      anchors.left: mainLayout.left
              //      Layout.rowSpan: 2
                    spacing: 24
                    Component.onCompleted: {
                        console.log("Left column: "+left_col_inside.width+" "+left_col_inside.height)
                    }

                    Item{
                        width: 64
                        height: 96
                        anchors.horizontalCenter: left_col_inside.horizontalCenter

                        Image {
                            id: home_ico
                            source: "img/inside_icon.png"
                            visible: false
                        }

                        DropShadow {
                            source: home_ico
                            horizontalOffset: 1
                            verticalOffset: 1
                            radius: 1
                            samples: 4
                            color: 'slategray'
                            anchors.fill: source
                        }
                    }


                    Item{
                        width: 240
                        height: 64
                        anchors.horizontalCenter: left_col_inside.horizontalCenter

                            Image {
                                id: temp_ico
                                source: "img/measurement-units-temperature-icon.png"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left; anchors.leftMargin: 24
                                visible: false
                            }

                            DropShadow {
                                source: temp_ico
                                horizontalOffset: 1
                                verticalOffset: 1
                                radius: 0
                                samples: 0
                                color: 'slategray'
                                anchors.fill: source
                            }

                            TextShadow { id: temperature_txt; anchors.left: temp_ico.right; anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.temperature; size: 32 }
                            TextShadow { anchors.baseline: temperature_txt.baseline; anchors.left: temperature_txt.right; anchors.leftMargin: 5; text: qsTr(" \u00B0")+qsTr("C"); size: 24 }
                        }

                    Item{
                        width: 240
                        height: 64
                        anchors.horizontalCenter: left_col_inside.horizontalCenter

                            Image {
                                id: pressure_ico
                                source: "img/measurement-units-pressure-icon.png"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left; anchors.leftMargin: 24
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

                            TextShadow { id: pressure_txt; anchors.left: pressure_ico.right; anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.pressure; size: 32 }
                            TextShadow { anchors.baseline: pressure_txt.baseline; anchors.left: pressure_txt.right; anchors.leftMargin: 5; text: qsTr(" hPa"); size: 24 }
                        }

                    Item{
                        width: 240
                        height: 64
                        anchors.horizontalCenter: left_col_inside.horizontalCenter

                            Image {
                                id: humidity_ico
                                source: "img/measurement-units-humidity-icon.png"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left; anchors.leftMargin: 24
                                visible: false
                            }

                            DropShadow {
                                source: humidity_ico
                                horizontalOffset: 1
                                verticalOffset: 1
                                radius: 1
                                samples: 4
                                color: 'slategray'
                                anchors.fill: source
                            }

                            TextShadow { id: humidity_txt; anchors.left: humidity_ico.right; anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.humidity; size: 32 }
                            TextShadow { anchors.baseline: humidity_txt.baseline; anchors.left: humidity_txt.right; anchors.leftMargin: 5; text: qsTr(" %rH"); size: 24 }

                        }
                    }
                }

                Rectangle {
                    id: right_col
                    color: 'deepskyblue'
                    width: main_row.width * 0.7
                    height: main_row.height;

                    Column {
                        id: right_col_inside
    //                    width: right_col.width
     //                   height: right_col.height
    //                    Layout.fillWidth: true
    //                    Layout.fillHeight: true
                        anchors.centerIn: parent
                        anchors.margins: 30
//
                        spacing: 10
                        Component.onCompleted: {
                            console.log("Right column: "+right_col_inside.width+" "+right_col_inside.height)
                        }

                        TextShadow { anchors.horizontalCenter: parent.horizontalCenter; id: location_txt; text: "Rzeszów, PL"; size: 24 }
                        Row {
                            id: right_col_row2
                            height: main_row.height * 0.5

                            anchors.horizontalCenter: parent.horizontalCenter
                     //       anchors.centerIn: parent
                       //     anchors.verticalCenter: parent.verticalCenter

                            spacing: 5
                            Column {
                                spacing: 10
                      //          anchors.right: sunny_ico_container.left; anchors.rightMargin: 96
                           //     anchors.verticalCenter:  sunny_ico_container.verticalCenter
                                TextShadow { id: windOut_txt; text: GuiPainter.windDirOut+qsTr(" ")+GuiPainter.windSpeedOut+qsTr(" kph"); size: 24 }
                                TextShadow { id: humidityOut_txt; text: GuiPainter.humidityOut ; size: 24 }
                             }
                            Item{
                                id: sunny_ico_container
                                width: sunny_ico.width
                                height: sunny_ico.height
                                anchors.verticalCenter: parent.verticalCenter

                                Image {
                                    id: sunny_ico
                                    source: "img/sunny_icon.png"
                                    visible: false
                                }

                                DropShadow {
                                    source: sunny_ico
                                    horizontalOffset: 1
                                    verticalOffset: 1
                                    radius: 1
                                    samples: 4
                                    color: 'slategray'
                                    anchors.fill: source
                                }
                            }
                            Item {
                                anchors.left: sunny_ico_container.right; anchors.leftMargin: 64
                                anchors.verticalCenter:  sunny_ico_container.verticalCenter
                                TextShadow { id: deg_txt; anchors.centerIn: parent; text: GuiPainter.temperatureOut; size: 42 }
                                TextShadow { anchors.left: deg_txt.right; anchors.baseline: deg_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 32 }
                             }
                        }

                        Item {
                            width: parent.width
                            height: parent.height * 0.15
                            Rectangle {
                                id: line
                                anchors.centerIn: parent
                                width: parent.width
                                height: 2
                                Rectangle {
                                    width: 10; height: 10;
                                    radius: 90
                                    anchors.left: line.left
                                    anchors.verticalCenter: line.verticalCenter
                                }
                                Rectangle {
                                    width: 10; height: 10;
                                    radius: 90
                                    anchors.right: line.right
                                    anchors.verticalCenter: line.verticalCenter
                                }
                            }

                        }

                    }
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

                        TextShadow {
                            anchors.centerIn: parent; anchors.margins: 5
                            text: qsTr("Random"); size: 12; shadowColor: 'black'
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
                    }

                }

            }
        }

}
