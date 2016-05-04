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

    readonly property string c00_L: ""
    readonly property string c00_H: ""
    readonly property string c00_R: ""

    readonly property string c00_05L: ""
    readonly property string c00_05H: ""
    readonly property string c00_05R: ""

    readonly property string c05_10L: ""
    readonly property string c05_10H: ""
    readonly property string c05_10R: ""

    readonly property string c10_15L: "#40E0D0"
    readonly property string c10_15H: "#00CED1"
    readonly property string c10_15R: "#008B8B"

    readonly property string c15_20L: "#dce177"
    readonly property string c15_20H: "#6eaf29"
    readonly property string c15_20R: "#7ab600"

    readonly property string c20_25L: "#ffdd62"
    readonly property string c20_25H: "#ffc800"
    readonly property string c20_25R: "#ff9e00"

    readonly property string c25_30L: "#ffcd19"
    readonly property string c25_30H: "#ffa500"
    readonly property string c25_30R: "#ff7300"

    readonly property string c30_L: ""
    readonly property string c30_H: ""

    Component.onCompleted: {
        console.log("Window size:"+root.width+" "+root.height)
        console.log("Start reading stuff")
        GuiPainter.startReadingData();
    }

    FontLoader { id: ubuntuFont; source: "fonts/Ubuntu-L.ttf" }

    Column {
        id: main_container
        anchors.fill: parent
        spacing: 5

        Row {
            id: main_row
            width: parent.width
            height: parent.height * 0.9
            anchors.bottom: root.bottom
            spacing: 10
      //      anchors.margins: 15

            Component.onCompleted: {
                console.log("GridLayout: "+main_row.width+" "+main_row.height)
            }

            Rectangle {
                id: left_col
                width: main_row.width * 0.3
                height: main_row.height
  //              color: 'sandybrown'
//                border.color: '#ffffff'
//                border.width: 5
                anchors.verticalCenter: parent.verticalCenter
                gradient: Gradient {                    
                    GradientStop { id: left_col_H; position: 0.0; color: "#B69DB0" }
                    GradientStop { id: left_col_L; position: 1.0; color: "#AEA79F" }
                }


                Column {
                    id: left_col_inside
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    anchors.margins: 20
                    spacing: 10
                    Component.onCompleted: {
                        console.log("Left column: "+left_col_inside.width+" "+left_col_inside.height)
                    }

//                    Item{
//                        width: parent.width
//                        height: parent.height * 0.3
//                        anchors.horizontalCenter: left_col_inside.horizontalCenter

//                        Image {
//                            id: home_ico
//                            source: "img/inside_icon.png"
//                            visible: false
//                            anchors.centerIn: parent
//                        }

//                        DropShadow {
//                            source: home_ico
//                            horizontalOffset: 1
//                            verticalOffset: 1
//                            radius: 1
//                            samples: 4
//                            color: 'slategray'
//                            anchors.fill: source
//                        }
//                    }

                    Item {
                        width: parent.width
                        height: parent.height * 0.05
                    }

                    Rectangle {
                        id: inside_ico_container
                        width: parent.width * 0.5
                        height: parent.width * 0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                        radius: 180
                //        border.color: "#ffffff"
//                        border.width: 2

                        Image {
                            sourceSize: Qt.size(parent.height*0.9, parent.height*0.9)
                            id: inside_ico
                            source: "img/home.svg"
                            smooth: true
                         //   visible: false
                            anchors.centerIn: inside_ico_container
                            anchors.verticalCenter: parent.verticalCenter

                        }

//                        DropShadow {
//                            source: outside_ico
//                            horizontalOffset: 1
//                            verticalOffset: 1
//                            radius: 1
//                            samples: 4
//                            color: 'slategray'
//                            anchors.fill: source
//                        }
                    }

                    Item {
                        width: parent.width
                        height: parent.height * 0.4
                        anchors.horizontalCenter: parent.horizontalCenter

                        TextShadow { id: temperature_txt;
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.horizontalCenterOffset: -20
                            anchors.verticalCenter: parent.verticalCenter
                            text: GuiPainter.temperature; size: 64 }
                        TextShadow { id: temperature_txt_unit;  anchors.left: temperature_txt.right;  anchors.baseline: temperature_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 32 }
                    }

                    Rectangle {
                        width: parent.width + 5
                        height: parent.height * 0.12
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#9e415d"

                        Item{
                            width: humidity_ico.width
                            height: humidity_ico.height
                            anchors.verticalCenter: parent.verticalCenter;
                            anchors.right: humidity_txt.left
                            anchors.rightMargin: width * 0.5

                            Image {
                                id: humidity_ico
                                source: "img/measurement-units-humidity-icon.png"
                                anchors.centerIn: parent
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
                        }

                        TextShadow { id: humidity_txt; anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.humidity + qsTr("%"); size: 20 }
                    }

                }
            }

            Rectangle {
                id: middle_col
                width: main_row.width * 0.4 - 20
                height: main_row.height
                anchors.verticalCenter: parent.verticalCenter
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#1b83b9" }
                    GradientStop { position: 1.0; color: "#00a1e4" }
                }

                Column {
                    id: middle_col_inside
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    anchors.margins: 20
                    spacing: 5

                    Component.onCompleted: {
                        console.log("Right column: "+width+" "+height)
                    }

                   // Row {
                    //    id: right_col_row2
                    //    width: parent.width
                   //     height: parent.height * 0.6
                   //     anchors.horizontalCenter: parent.horizontalCenter
                    Item {
                     width: parent.width
                     height: parent.height * 0.3
                     TextShadow { id: tempOut_txt; anchors.centerIn: parent;  text: GuiPainter.temperatureOut; size: 32 }
                    }

                        Item{
                            id: weather_ico_container
                            width: parent.width
                            height: parent.width * 0.3
                            //       anchors.left: parent.left; anchors.leftMargin: 30
                            anchors.horizontalCenter: parent.horizontalCenter

                            Image {
                                sourceSize: Qt.size(parent.width*0.4, parent.width*0.4)
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
//                        Item {
//                            id: tempOut_container
//                            width: parent.width * 0.4
//                            height: parent.height
//                            // anchors.left: weather_ico_container.right; anchors.leftMargin: 64
//                            anchors.verticalCenter:  weather_ico_container.verticalCenter

//                            TextShadow { id: deg_txt; anchors.left: parent.left; anchors.leftMargin: 20; text: GuiPainter.temperatureOut; size: 42 }
//                            TextShadow { anchors.left: deg_txt.right; anchors.baseline: deg_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 24 }
//                            TextShadow { id: cond_txt;
//                                anchors.left: parent.left; anchors.leftMargin: 15
//                                anchors.top: deg_txt.bottom
//                                text: GuiPainter.conditionOut; size: 24 }
//                        }
                //    }
                        Item {
                         width: parent.width
                         height: parent.height * 0.2
                      TextShadow { id: cond_txt; anchors.centerIn: parent;  text: GuiPainter.conditionOut; size: 24 }
                        }

                      Rectangle {
                          width: parent.width + 5
                          height: parent.height * 0.12
                          anchors.horizontalCenter: parent.horizontalCenter
                          color: "#13598a"

                            Item {
                                id: wind_dir_container
                                width: parent.width * 0.35
                                height: parent.width * 0.35
                                rotation: GuiPainter.windDirOut - 45.0
                                anchors.verticalCenter: parent.verticalCenter

                                Image {
                                    sourceSize: Qt.size(parent.height*0.5, parent.height*0.5)
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
                          width: parent.width + 5
                          height: parent.height * 0.12
                          anchors.horizontalCenter: parent.horizontalCenter
                          color: "#13598a"

                            Item {
                                width: pressure_ico.width
                                height: pressure_ico.height
                                anchors.verticalCenter: parent.verticalCenter;

                                Image {
                                    id: pressure_ico
                                    source: "img/measurement-units-pressure-icon.png"
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

                }
            }

            Rectangle {
                id: right_col
                width: main_row.width * 0.3
                height: main_row.height
          //      color: 'darkturquoise'
//                border.color: '#ffffff'
//                border.width: 5
                anchors.verticalCenter: parent.verticalCenter
                gradient: Gradient {
                    GradientStop { position: 0.0; color: c20_25H }
                    GradientStop { position: 1.0; color: c20_25L }
                }

                Column {
                    id: right_col_inside
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    anchors.margins: 20
                    spacing: 10
       //             padding: 15
                    Component.onCompleted: {
                        console.log("Left column: "+width+" "+height)
                    }

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
                //        border.color: "#ffffff"
//                        border.width: 2

                        Image {
                            sourceSize: Qt.size(parent.height*0.9, parent.height*0.9)
                            id: outside_ico
                            source: "img/hills.svg"
                            smooth: true
                         //   visible: false
                            anchors.centerIn: outside_ico_container
                            anchors.verticalCenter: parent.verticalCenter

                        }

//                        DropShadow {
//                            source: outside_ico
//                            horizontalOffset: 1
//                            verticalOffset: 1
//                            radius: 1
//                            samples: 4
//                            color: 'slategray'
//                            anchors.fill: source
//                        }
                    }

                    Item{
                        width: parent.width
                        height: parent.height * 0.4
                        anchors.horizontalCenter: parent.horizontalCenter

                        TextShadow { id: temperatureOut_txt
                                     anchors.horizontalCenter: parent.horizontalCenter
                                     anchors.horizontalCenterOffset: -20
                                     anchors.verticalCenter: parent.verticalCenter
                                     text: GuiPainter.feelslikeOut; size: 64 }
                        TextShadow { id: temperatureOut_txt_unit; anchors.left: temperatureOut_txt.right; anchors.baseline: temperatureOut_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 32 }
                    }


                    Rectangle {
                        width: parent.width + 5
                        height: parent.height * 0.12
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: c20_25R

                        Item{
                            anchors.fill: parent
                            anchors.horizontalCenter: parent.horizontalCenter

                            Item{
                                width: humidityOut_ico.width
                                height: humidityOut_ico.height
                                anchors.verticalCenter: parent.verticalCenter;

                                Image {
                                    id: humidityOut_ico
                                    source: "img/measurement-units-humidity-icon.png"
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

                }
            }

        }

        Rectangle {
            id: bottom_bar
            width: root.width; height: root.height * 0.1;
            color: '#5E2750'
            border.color: '#ffffff'
       //     border.width: 5

            Component.onCompleted: {
                console.log("Topbar size:"+width+" "+height)
            }

            Item {
                id: bottom_bar_container
                anchors.fill: parent

                Text { id: date_txt
                    text: currentDate.toLocaleDateString()
                    font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12; font.bold: true
                    anchors.centerIn: parent
                }
                Text { id: time_txt
                    text: GuiPainter.currentTime
                    font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12; font.bold: true
                    anchors.right: parent.right
                    anchors.rightMargin: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text { id: location_txt;
                    anchors.verticalCenter: parent.verticalCenter
                             anchors.left: parent.left
                             anchors.leftMargin: parent.height; text: "Rzeszów, PL"; font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12; font.bold: true }
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
