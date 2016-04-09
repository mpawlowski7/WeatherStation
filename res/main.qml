import QtQuick 2.5
//import weatherstation.gui 1.0
//import weatherstation.led 1.0

import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

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

    color: 'slategray'

    Component.onCompleted: {
        console.log("Window size:"+root.width+" "+root.height)
        console.log("Start reading stuff")
        GuiPainter.startReadingData();
    }

    FontLoader { id: ubuntuFont; source: "fonts/Ubuntu-R.ttf" }

    Rectangle {
        id: background
        anchors.right: parent.right
        width: root.width * 0.7; height: root.height

     //   color: 'deepskyblue'
        gradient: Gradient{
            GradientStop { position: 1 ; color: 'deepskyblue'}
            GradientStop { position: 0 ; color: 'dodgerblue'}
        }

        layer.enabled: true

        layer.effect: DropShadow {
            horizontalOffset: -(background.width * 0.01)
            verticalOffset: 0
            radius: 4
            samples: 8
            color: 'darkslategray'
        }
    }

    Rectangle { id: separator; width: 1; height: 480; anchors.right: background.left; color: 'dodgerblue'; }

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

        GridLayout {
            id: mainLayout
            anchors.fill: parent

            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

            columnSpacing: 0
            rowSpacing: 0
            columns: 2
            rows: 2
     //       anchors.centerIn: parent
            Component.onCompleted: {
                console.log("GridLayout: "+mainLayout.width+" "+mainLayout.height)
            }

            Column {
                id: left_col
                width: mainLayout.width * 0.3
                height: mainLayout.height

          //      anchors.left: mainLayout.left
          //      Layout.rowSpan: 2
                spacing: 24
                Component.onCompleted: {
                    console.log("Left column: "+left_col.width+" "+left_col.height)
                }

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
                width: mainLayout.width * 0.7
                height: mainLayout.height;
          //      anchors.horizontalCenter: right_col.horizontalCenter
                spacing: 2
                Component.onCompleted: {
                    console.log("Right column: "+right_col.width+" "+right_col.height)
                }

                TextShadow { anchors.right: parent.right; id: location_txt; text: "Rzeszów"; size: 32 }


//                Row {
//                    width: right_col.width / 2
//                    height: sunny_ico.height * 2
//             //       anchors.horizontalCenter: right_col.horizontalCenter
//                    spacing: 20

                    Item{
                        id: sunny_ico_container
                        width: sunny_ico.width
                        height: sunny_ico.height
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
                    TextShadow { id: deg_txt; anchors.margins: 5; text: qsTr("26,3"); size: 64 }
                    TextShadow { anchors.baseline: deg_txt.baseline; text: qsTr(" \u00B0")+qsTr("C"); size: 32 }
            //    }

                TextShadow { id: time_txt; anchors.margins: 5; text: GuiPainter.currentTime; size: 96 }
            }

       }

        Item {
            id: drawer_container
            anchors.fill: parent
            Drawer {
                id: drawer
                position: Qt.RightEdge
                visualParent: drawer_container
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
        }

}
