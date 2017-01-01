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

    Component.onCompleted: {
        console.log("Pixel ratio:" + Screen.devicePixelRatio)
        console.log("Pixel density:" + Screen.pixelDensity * 25.4)
        console.log("Pixel logical density:" + Screen.logicalPixelDensity * 25.4)
        console.log("Width: " + Screen.width)
        console.log("Height: " + Screen.height)
    }

    Rectangle {
        id: main_container
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.margins: 0
        color: "#32343c"

        Rectangle {
            id: splash_screen
            anchors.centerIn: parent
            width: parent.width * 0.5
            height: parent.height * 0.5
            visible: true
            TextShadow {
                anchors.centerIn: parent
                text: "Connecting to server..."
            }
        }

        Item {
            anchors.fill: parent

            Loader {
                anchors.fill: parent
                sourceComponent: main_row
            }

            Component {
                    id: main_row
                    RowLayout {
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

        }
    }
}
