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
        var temp = parseFloat(GuiPainter.feelslikeOut);
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

                ForecastView {
                    id: left_col_inside
                }

            }

            Rectangle {
                id: mid_col
                width: main_row.width * 0.35
                height: main_row.height
                anchors.verticalCenter: parent.verticalCenter
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#9d415c" }
                    GradientStop { position: 1.0; color: "#9d717e" }
                }

                InsideView{}

            }

            Rectangle {
                id: right_col
                width: main_row.width * 0.35
                height: main_row.height
                anchors.verticalCenter: parent.verticalCenter
                gradient: Gradient {
                    GradientStop { id: right_col_GH; position: 0.0; color: "darkgray" }
                    GradientStop { id: right_col_GL; position: 1.0; color: "gray" }
                }

                OutsideView {}

            }

        }

        Rectangle {
            id: bottom_bar
            width: root.width; height: root.height * 0.1;
            color: '#5E2750'

            Item {
                id: bottom_bar_container
                anchors.fill: parent

                Text { id: date_txt
                    text: currentDate.toLocaleDateString()
                    font.family: ubuntuFont.name; color: '#ffffff'; font.pointSize: 12; font.bold: true
                    anchors.centerIn: parent
                }
                Text { id: time_txt
                    text: currentDate.toLocaleTimeString()
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
