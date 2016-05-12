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

    property date currentDate: new Date()

    readonly property string c00_L: ""
    readonly property string c00_H: ""
    readonly property string c00_R: ""

    readonly property string c00_05L: ""
    readonly property string c00_05H: ""
    readonly property string c00_05R: ""

    readonly property string c05_10L: "#3ab7e4"
    readonly property string c05_10H: "#009e6e"
    readonly property string c05_10R: "#006959"

    readonly property string c10_15L: "#00b499"
    readonly property string c10_15H: "#94c629"
    readonly property string c10_15R: "#00a088"

    readonly property string c15_20L: "#ffd12d"
    readonly property string c15_20H: "#6eaf29"

    readonly property string c20_25L: "#beda29"
    readonly property string c20_25H: "#e3b800"

    readonly property string c25_30L: "#ffcd19"
    readonly property string c25_30H: "#ffa500"

    readonly property string c30_L: ""
    readonly property string c30_H: ""

    function updateGradientColor()
    {
        var temp = parseFloat(GuiPainter.temperatureOut);
        switch(true)
        {
            case (5.0 <= temp && temp < 10.0):
                right_col_GH.color = c05_10H;
                right_col_GL.color = c05_10L;
                right_col_GR.color = c05_10H;
                break;
            case (10.0 <= temp && temp < 15.0):
                right_col_GH.color = c10_15H;
                right_col_GL.color = c10_15L;
                right_col_GR.color = c10_15R;
                break;
            case (15.0 <= temp && temp < 20.0):
                right_col_GH.color = c15_20H;
                right_col_GL.color = c15_20L;
                right_col_GR.color = c15_20H;
                break;
            case (20.0 <= temp && temp < 25.0):
                right_col_GH.color = c20_25H;
                right_col_GL.color = c20_25L;
                right_col_GR.color = c20_25H;
                break;
            case (25.0 <= temp && temp < 30.0):
                right_col_GH.color = c25_30H;
                right_col_GL.color = c25_30L;
                right_col_GR.color = c25_30H;
                break;
        }
    }

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

            Rectangle {
                id: left_col
                width: main_row.width * 0.3
                height: main_row.height
                anchors.verticalCenter: parent.verticalCenter
                gradient:
                    Gradient {
                        GradientStop { position: 0.0; color: "#1b83b9" }
                        GradientStop { position: 1.0; color: "#78cee4" }
                    }
                clip: true

                Item {
                    id: left_col_inside
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
           //         anchors.margins: 20
          //          spacing: 10

                    Component.onCompleted: {
                        console.log("Right column: "+width+" "+height)
                    }

                      Item {
                           width: parent.width
                           height: parent.height * 0.15
                           anchors.bottom: weather_ico_container.top
                           TextShadow { id: forecast_txt
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.horizontalCenterOffset: -10
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: GuiPainter.temperatureOut; size: 32 }
                           TextShadow { id: forecast_txt_unit; anchors.left: forecast_txt.right; anchors.baseline: forecast_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 14 }
                       }

                      Rectangle{
                          id: weather_ico_container
                          width: parent.width * 0.6
                          height: parent.width * 0.6
                          color: "transparent"
                          radius: 180
                          anchors.centerIn: parent

                          Image {
                              sourceSize: Qt.size(parent.width*1.5, parent.width*1.5)
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
                              opacity: 1
                              anchors.fill: source
                          }
                        }

                        Item {
                           width: parent.width
                           height: parent.height * 0.15
                           anchors.top: weather_ico_container.bottom
                           TextShadow { id: cond_txt; anchors.centerIn: parent;  text: GuiPainter.conditionOut; size: 24 }
                        }

//                    Item{
//                        id: weather_ico_container2
//                        width: parent.width
//                        height: parent.width * 0.4
//                        anchors.horizontalCenter: parent.horizontalCenter

//                        Image {
//                            sourceSize: Qt.size(parent.width, parent.width)
//                            id: weather_ico2
//                            source: "img/"+GuiPainter.conditionIcon+".svg"
//                            smooth: true
//                            visible: false
//                            anchors.centerIn: weather_ico_container2
//                        }

//                        DropShadow {
//                            source: weather_ico2
//                            horizontalOffset: 1
//                            verticalOffset: 1
//                            radius: 1
//                            samples: 4
//                            color: 'slategray'
//                            anchors.fill: source
//                        }
//                    }

                }
            }

            Rectangle {
                id: mid_col
                width: main_row.width * 0.35
                height: main_row.height
                anchors.verticalCenter: parent.verticalCenter
                gradient: Gradient {                    
                    GradientStop { id: left_col_H; position: 0.0; color: "#9d415c" }
                    GradientStop { id: left_col_L; position: 1.0; color: "#9d717e" }
                }


                Column {
                    id: mid_col_inside
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    anchors.margins: 20
                    spacing: 10
                    Component.onCompleted: {
                        console.log("Left column: "+left_col_inside.width+" "+left_col_inside.height)
                    }

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
            }

            Rectangle {
                id: right_col
                width: main_row.width * 0.35
                height: main_row.height
          //      color: 'darkturquoise'
//                border.color: '#ffffff'
//                border.width: 5
                anchors.verticalCenter: parent.verticalCenter
                gradient: Gradient {
                    GradientStop { id: right_col_GH; position: 0.0; color: c20_25H }
                    GradientStop { id: right_col_GL; position: 1.0; color: c20_25L }
                }

                Column {
                    id: right_col_inside
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    anchors.margins: 20
                    spacing: 5
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
                //        visible: false
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
                   //     visible: false
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
                   //     visible: false
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
            }

        }

        Rectangle {
            id: bottom_bar
            width: root.width; height: root.height * 0.1;
            color: '#5E2750'
      //      border.color: '#ffffff'
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

                    MouseArea {
                        id: btn_random_ma
                        anchors.fill: parent
                        onClicked: LedPainter.randomness();
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
