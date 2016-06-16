import weatherstation.gui 1.0

import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: parent.width * 0.35
    height: parent.height
    anchors.verticalCenter: parent.verticalCenter

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

    readonly property string c15_20L: "#6eaf29"
    readonly property string c15_20H: "#e9c008"
    readonly property string c15_20R: "#639e25"

    readonly property string c20_25L: "#a7c629"
    readonly property string c20_25H: "#ffa009"
    readonly property string c20_25R: "#8faa23"

    readonly property string c25_30L: "#e3b800"
    readonly property string c25_30H: "#ff8808"
    readonly property string c25_30R: "#c8a200"

    readonly property string c30_L: "#ff9100"
    readonly property string c30_H: "#ff6400"
    readonly property string c30_R: "#e98400"

    function updateGradientColor()
    {
        var temp = parseFloat(GuiPainter.currentWeather["feelslike_c"]);
        switch(true)
        {
        case (temp < 0.0):
            right_col_GH.color = c00_H;
            right_col_GL.color = c00_L;
            right_col_GR.color = c00_R;
            break;
        case (0.0 <= temp && temp < 5.0):
            right_col_GH.color = c00_05H;
            right_col_GL.color = c00_05L;
            right_col_GR.color = c00_05R;
            break;
        case (5.0 <= temp && temp < 10.0):
            right_col_GH.color = c05_10H;
            right_col_GL.color = c05_10L;
            right_col_GR.color = c05_10R;
            break;
        case (10.0 <= temp && temp < 15.0):
            right_col_GH.color = c10_15H;
            right_col_GL.color = c10_15L;
            right_col_GR.color = c10_15R;
            break;
        case (15.0 <= temp && temp < 20.0):
            right_col_GH.color = c15_20H;
            right_col_GL.color = c15_20L;
            right_col_GR.color = c15_20R;
            break;
        case (20.0 <= temp && temp < 25.0):
            right_col_GH.color = c20_25H;
            right_col_GL.color = c20_25L;
            right_col_GR.color = c20_25R;
            break;
        case (25.0 <= temp && temp < 30.0):
            right_col_GH.color = c25_30H;
            right_col_GL.color = c25_30L;
            right_col_GR.color = c25_30R;
            break;
        case (temp >= 30):
            right_col_GH.color = c30_H;
            right_col_GL.color = c30_L;
            right_col_GR.color = c30_R;
            break;
        }
    }
    gradient: Gradient {
        GradientStop { id: right_col_GH; position: 0.0; color: "darkgray" }
        GradientStop { id: right_col_GL; position: 1.0; color: "gray" }
    }

    Column {
        id: wrapper
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        anchors.margins: 20
        spacing: 2

//        Item {
//            width: parent.width
//            height: parent.height * 0.05
//        }

        //        Rectangle {
        //            id: outside_ico_container
        //            width: parent.width * 0.5
        //            height: parent.width * 0.5
        //            anchors.horizontalCenter: parent.horizontalCenter
        //            radius: 180

        //            Image {
        //                sourceSize: Qt.size(parent.height*0.9, parent.height*0.9)
        //                id: outside_ico
        //                source: "img/hills.svg"
        //                smooth: true
        //                anchors.centerIn: outside_ico_container
        //                anchors.verticalCenter: parent.verticalCenter

        //            }

        //        }
        TextShadow { id: date_txt; text: GuiPainter.currentDateTime["date"]; size: 16 }
        TextShadow { id: location_txt; text: GuiPainter.currentWeather["location"]; size: 16 }
//        Rectangle{
//            id: outside_ico_container
//            width: parent.width
//            height: parent.height * 0.35
//            color: "transparent"
//            //      radius: 180
//            anchors.horizontalCenter: wrapper.horizontalCenter
//            //            Image {
//            //                sourceSize: Qt.size(parent.width*0.9, parent.width*0.9)
//            //                id: outside_ico
//            //                source: "img/"+GuiPainter.currentWeather["icon"]+".svg"
//            //                smooth: true
//            //                visible: false
//            //                anchors.centerIn: outside_ico_container
//            //            }

//            //            DropShadow {
//            //                source: outside_ico
//            //                horizontalOffset: 1
//            //                verticalOffset: 1
//            //                radius: 1
//            //                samples: 4
//            //                color: 'slategray'
//            //                opacity: 1
//            //                anchors.fill: source
//            //            }
//       }


        Column{
            width: parent.width
            height: parent.height * 0.5
     //       anchors.horizontalCenter: parent.horizontalCenter

            WeatherIcon {
                type: GuiPainter.currentWeather["icon"]
                size: 48
                anchors.horizontalCenter: parent.horizontalCenter
            }
            TextShadow { id: temperatureOut_txt
           //     anchors.horizontalCenter: parent.horizontalCenter
          //      anchors.horizontalCenterOffset: -10
                anchors.horizontalCenter: parent.horizontalCenter
                text: GuiPainter.currentWeather["feelslike_c"] + qsTr("\u00B0"); size: 32 }
      //      TextShadow { id: temperatureOut_txt_unit; anchors.left: temperatureOut_txt.right; anchors.baseline: temperatureOut_txt.baseline; text: qsTr("\u00B0"); size: 16 }
        }

        Rectangle {
            id: right_col_GR
            width: parent.width/* * 1.05*/
            height: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            color: right_col_GR.color

            Item {
                id: wind_dir_container
                width: parent.width * 0.35
                height: parent.width * 0.35
                rotation: GuiPainter.currentWeather["wind_degrees"] - 45.0
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
            TextShadow { id: windOut_txt; text: GuiPainter.currentWeather["wind_kph"]+qsTr(" km/h"); size: 16
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            width: parent.width/* * 1.05*/
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
                text: GuiPainter.pressure+qsTr(" hPa"); size: 16 }

        }


        Rectangle {
            width: parent.width/* * 1.05*/
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
                anchors.verticalCenter: parent.verticalCenter; text: GuiPainter.currentWeather["relative_humidity"]; size: 16 }

        }

    }
}
