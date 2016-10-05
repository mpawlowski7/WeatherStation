import weatherstation.gui 1.0

import QtQuick 2.7

Rectangle {
    id: root
    anchors.verticalCenter: parent.verticalCenter

    property string lowColor: "slategray"
    property string highColor: "gray"

    readonly property string c00_L: "#639eff"
    readonly property string c00_H: "#639eff"
    readonly property string c00_R: ""

    readonly property string c00_05L: "#89dcff"
    readonly property string c00_05H: "#76c2ff"
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
            highColor = c00_H;
            lowColor = c00_L;
            break;
        case (0.0 <= temp && temp < 5.0):
            highColor = c00_05H;
            lowColor = c00_05L;
            break;
        case (5.0 <= temp && temp < 10.0):
            highColor = c05_10H;
            lowColor = c05_10L;
            break;
        case (10.0 <= temp && temp < 15.0):
            highColor = c10_15H;
            lowColor = c10_15L;
            break;
        case (15.0 <= temp && temp < 20.0):
            highColor = c15_20H;
            lowColor = c15_20L;
            break;
        case (20.0 <= temp && temp < 25.0):
            highColor = c20_25H;
            lowColor = c20_25L;
            break;
        case (25.0 <= temp && temp < 30.0):
            highColor = c25_30H;
            lowColor = c25_30L;
            break;
        case (temp >= 30):
            highColor = c30_H;
            lowColor = c30_L;
            break;
        }
    }

    color: "#3f4851"
    border.color: highColor
    border.width: parent.width * 0.006

    Item {
        width: parent.width * 0.9
        height: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        TextShadow {
            id: batteryOut_txt
            text: awesome.icons.fa_battery_full
            textColor: highColor
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        TextShadow {
            id: singalOut_txt
            text: awesome.icons.fa_signal
            textColor: highColor
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Column {
        id: outside_sensor
        width: root.width
        height: root.height * 0.4
        spacing: height * 0.05
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -parent.height * 0.2

        WeatherIcon {
            type: GuiPainter.currentWeather["icon"]
            size: 48
            anchors.horizontalCenter: parent.horizontalCenter
            color: highColor
        }

        TextShadow {
            id: temperatureOut_txt
            anchors.horizontalCenter: parent.horizontalCenter
            text: GuiPainter.currentWeather["feelslike_c"] + qsTr("\u00B0");
            textColor: highColor
            size: 42
        }

        Row {
            height: parent.height * 0.1
            spacing: height * 0.3
            anchors.horizontalCenter: parent.horizontalCenter

            WeatherIcon {
                id: humidityOut_ico;
                anchors.verticalCenter: parent.verticalCenter
                type: "humidity"
                size: 12
                color: highColor
            }

            TextShadow {
                id: humidityOut_txt
                text: GuiPainter.currentWeather["relative_humidity"]
                anchors.verticalCenter: parent.verticalCenter
                size: 12
                textColor: highColor
            }
        }

        Item {
            width: parent.width * 0.9
            height: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                height: parent.height
                anchors.left: parent.left
                spacing: parent.height * 0.3

                WeatherIcon {
                    id: pressureOut_ico;
                    anchors.verticalCenter: parent.verticalCenter
                    type: "pressure"
                    size: 12
                    color: highColor
                }

                TextShadow {
                    id: pressureOut_txt
                    text: GuiPainter.pressure + qsTr("hPa")
                    anchors.verticalCenter: parent.verticalCenter
                    size: 12
                    textColor: highColor
                }
            }

            Row {
                height: parent.height
                anchors.right: parent.right
                spacing: parent.height * 0.3

                WeatherIcon {
                    id: windOut_ico;
                    anchors.verticalCenter: parent.verticalCenter
                    type: "wind"
                    size: 12
                    color: highColor
                    transform: Rotation { origin.x: windOut_ico.width/2; origin.y: windOut_ico.height/2; angle: GuiPainter.currentWeather["wind_dir"] }
                }

                TextShadow {
                    id: windOut_txt
                    anchors.verticalCenter: parent.verticalCenter
                    text: GuiPainter.currentWeather["wind_kph"]+qsTr(" km/h")
                    size: 12
                    textColor: highColor
                }
            }
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height * 0.15
        color: highColor
        anchors.bottom: parent.bottom

        TextShadow {
            shadowVisible: false
            textColor: "#ffffff"
            text: "Na zewnątrz"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            size: 14
        }

        Rectangle {
            width: parent.width
            height: parent.height * 0.12
            color: "#000000"
            opacity: 0.2
            anchors.bottom: parent.bottom
        }
    }
}
