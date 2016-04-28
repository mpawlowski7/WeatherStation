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

            Component.onCompleted: {
                console.log("Topbar size:"+width+" "+height)
             //   console.log("Start reading stuff")
             //   GuiPainter.startReadingData();
            }

            Item {
                id: top_bar_container
                anchors.fill: parent

                Text { id: date_txt
                    text: currentDate.toLocaleDateString()
                    font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12
                    anchors.centerIn: parent
                }
                Text { id: time_txt
                    text: GuiPainter.currentTime
                    font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
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
                //        anchors.margins: 30


                Column {
                    id: left_col_inside
                    anchors.fill: parent
                    anchors.margins: 30
                    spacing: 10
                    Component.onCompleted: {
                        console.log("Left column: "+left_col_inside.width+" "+left_col_inside.height)
                    }

                    Item{
                        width: parent.width
                        height: parent.height * 0.3
                        anchors.horizontalCenter: left_col_inside.horizontalCenter

                        Image {
                            id: home_ico
                            source: "img/inside_icon.png"
                            visible: false
                            anchors.centerIn: parent
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
                        width: parent.width
                        height: parent.height * 0.2
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

                        TextShadow { id: temperature_txt; anchors.left: temp_ico.right; anchors.leftMargin: 15; text: GuiPainter.temperature; size: 20 }
                        TextShadow { anchors.baseline: temperature_txt.baseline; anchors.left: temperature_txt.right; anchors.leftMargin: 5; text: qsTr(" \u00B0")+qsTr("C"); size: 20 }
                    }

                    Row{
                        width: parent.width
                        height: parent.height * 0.2
                        anchors.horizontalCenter: left_col_inside.horizontalCenter

                        spacing: 10
                        Item {
                            width: pressure_ico.width
                            height: pressure_ico.height
                            Image {
                                id: pressure_ico
                                source: "img/measurement-units-pressure-icon.png"
                                anchors.centerIn: parent
                           //     anchors.left: parent.left; anchors.leftMargin: 24
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

                        TextShadow { id: pressure_txt; anchors.verticalCenterOffset: 10; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.pressure; size: 20 }
                        TextShadow { anchors.baseline: pressure_txt.baseline; /*anchors.left: pressure_txt.right; anchors.leftMargin: 5;*/ text: qsTr(" hPa"); size: 20 }
                    }

                    Item{
                        width: parent.width
                        height: parent.height * 0.2
                        anchors.horizontalCenter: left_col_inside.horizontalCenter

                        Image {
                            id: humidity_ico
                            source: "img/measurement-units-humidity-icon.png"
                            anchors.verticalCenter: humidity_txt.verticalCenter
                            anchors.right: humidity_txt.left
                            anchors.rightMargin: width * 0.5
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

                        TextShadow { id: humidity_txt; /*anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter;*/ text: GuiPainter.humidity; size: 20 }
                        TextShadow { id: humidity_txt_unit; anchors.right: parent.right; anchors.baseline: humidity_txt.baseline; text: qsTr(" %rH"); size: 20 }

                    }
                }
            }

            Rectangle {
                id: right_col
                color: 'deepskyblue'
                width: main_row.width * 0.7
                height: main_row.height

                Column {
                    id: right_col_inside
                    //                    width: right_col.width
                    //                   height: right_col.height
                    //                    Layout.fillWidth: true
                    //                    Layout.fillHeight: true
                    anchors.fill: parent
                    anchors.margins: 10
                    //
                    spacing: 10
                    Component.onCompleted: {
                        console.log("Right column: "+width+" "+height)
                    }

                    Item {
                        width: parent.width
                        height: parent.height * 0.2
                        anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            id: location_ico
                            source: "img/map_marker.png"
                            visible: false
                            anchors.right: location_txt.left
                            anchors.rightMargin: 20
                            anchors.verticalCenter: location_txt.verticalCenter
                        }

                        DropShadow {
                            source: location_ico
                            horizontalOffset: 1
                            verticalOffset: 1
                            radius: 1
                            samples: 4
                            color: 'slategray'
                            anchors.fill: source
                        }
                        TextShadow { id: location_txt
                            text: "Rzeszów, PL"; size: 24
                            anchors.centerIn: parent

                        }
                    }
                    Row {
                        id: right_col_row2
                        width: parent.width
                        height: parent.height * 0.6
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 0

                        Item{
                            id: weather_ico_container
                            width: parent.width * 0.5
                            height: parent.height
                            //       anchors.left: parent.left; anchors.leftMargin: 30
                            anchors.verticalCenter: parent.verticalCenter

                            Image {
                                sourceSize: Qt.size(parent.width*0.5, parent.width*0.5)
                                id: weather_ico
                                source: "img/"+GuiPainter.conditionIcon+".svg"
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
                                anchors.fill: source
                            }
                            //                                TextShadow { id: cond_txt
                            //                                             text: GuiPainter.conditionOut; size: 64
                            //                                             anchors.left: parent.left; }
                        }
                        Item {
                            id: tempOut_container
                            width: parent.width * 0.4
                            height: parent.height
                            // anchors.left: weather_ico_container.right; anchors.leftMargin: 64
                            anchors.verticalCenter:  weather_ico_container.verticalCenter

                            TextShadow { id: deg_txt; anchors.left: parent.left; anchors.leftMargin: 20; text: GuiPainter.temperatureOut; size: 32 }
                            TextShadow { anchors.left: deg_txt.right; anchors.baseline: deg_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 24 }
                            TextShadow { id: cond_txt;
                                anchors.left: parent.left; anchors.leftMargin: 15
                                //anchors.baseline: par
                                text: GuiPainter.conditionOut; size: 24 }
                        }
                    }

                    Item {
                        //spacing: 0
                        width: parent.width
                        height: parent.height * 0.2
                        //anchors.horizontalCenter: parent.horizontalCenter

                        Item {
                            width: parent.width * 0.5
                            height: parent.height
                            anchors.left: parent.left
                    //        anchors.bottom: parent.bottom

                            Item {
                                id: wind_dir_container
                                width: parent.width * 0.35
                                height: parent.width * 0.35
                                rotation: GuiPainter.windDirOut - 45.0
                                anchors.verticalCenter: windOut_txt.verticalCenter

                                Image {
                                    sourceSize: Qt.size(parent.height*0.5, parent.height*0.5)
                                    id: wind_dir_ico
                                    source: "img/compass.svg"
                                    smooth: true
                                    visible: false
                                    anchors.centerIn: wind_dir_container
                                    anchors.verticalCenter: parent.verticalCenter
                                    //          anchors.verticalCenterOffset: -24
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
                            TextShadow { id: windOut_txt; text: GuiPainter.windSpeedOut+qsTr(" km/h"); size: 24
                                anchors.left: wind_dir_container.right
                            }
                        }

                        Item {
                            id: humidty_out_container
                            width: parent.width * 0.5
                            height: parent.height
                            anchors.right: parent.right

                            Image {
                                sourceSize: Qt.size(parent.height*0.5, parent.height*0.5)
                                id: humidity_out_ico
                                source: "img/humidity_out.svg"
                                smooth: true
                                visible: false
                                anchors.verticalCenter: humidityOut_txt.verticalCenter
                                //          anchors.verticalCenterOffset: -24
                            }

                            DropShadow {
                                source: humidity_out_ico
                                horizontalOffset: 1
                                verticalOffset: 1
                                radius: 1
                                samples: 4
                                color: 'slategray'
                                anchors.fill: source
                            }

                            TextShadow { id: humidityOut_txt; anchors.left: humidity_out_ico.right; anchors.leftMargin: 10; text: GuiPainter.humidityOut ; size: 24 }
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
