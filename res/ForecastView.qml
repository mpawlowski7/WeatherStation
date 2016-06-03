import weatherstation.gui 1.0

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: parent.width * 0.3
    height: parent.height
    anchors.verticalCenter: parent.verticalCenter
    gradient:
        Gradient {
        GradientStop { position: 0.0; color: "#1b83b9" }
        GradientStop { position: 1.0; color: "#78cee4" }
    }
    //  clip: true

    ScrollView {
        id: scroll
        width: root.width
        height: root.height
        anchors.centerIn: parent
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        flickableItem.interactive: true
        flickableItem.flickableDirection: Flickable.VerticalFlick
        flickableItem.boundsBehavior: Flickable.DragAndOvershootBounds

        property date today: new Date()
        property real contentHeight: root.height
        //    contentItem: wrapper


        flickableItem.onFlickStarted: {
            date_txt.visible = false
        }

        flickableItem.onFlickEnded: {
            console.log(contentItem.children[1]);
            flickableItem.contentY = scroll.height * Math.round(flickableItem.contentY/scroll.height);
            date_txt.text = contentItem.children[Math.round(flickableItem.contentY/scroll.height)].day;
            date_txt.visible = true;
        }

        Column {
            id: wrapper
            width: root.width
            height: scroll.contentHeight * 11
            spacing: 0
            anchors.top: parent.top

            Component.onCompleted: {
                fill10DayForecast();
            }

            SingledayView {
                id: current
                width: scroll.width
                height: scroll.height
                day: "Aktualnie"
                icon: GuiPainter.currentWeather["icon"]
                condition: GuiPainter.currentWeather["weather"]
                tempHigh: GuiPainter.currentWeather["temp_c"]
                tempLow: ""

                Component.onCompleted: {
                    console.log("Current weather icon: " + icon)
                }
            }

            function fill10DayForecast() {
                var component = Qt.createComponent("SingledayView.qml");
                if (component.status === Component.Ready) {
                    for(var i=0; i<10; i++) {
                        var singleDay =  component.createObject(wrapper,
                                                                { "objectName": "per_"+i,
                                                                    "id": "per_"+i,
                                                                    "width": scroll.width,
                                                                    "height": scroll.height,
                                                                    "day": GuiPainter.forecast["date"][i],
                                                                    "icon": GuiPainter.forecast["icon"][i],
                                                                    "condition": GuiPainter.forecast["conditions"][i],
                                                                    "tempHigh": GuiPainter.forecast["temp_high"][i],
                                                                    "tempLow": GuiPainter.forecast["temp_low"][i]
                                                                });
                        singleDay.doubleClick.connect(goToStart);
                    }
                }
            }

            function goToStart() {
                console.log("Going to start");
                //     while(scroll.flickableItem.contentY != 0)
                scroll.flickableItem.contentY = 0;
                date_txt.text = current.day;
            }


        }
    }

    Rectangle {
        id: date_txt_containter
        width: root.width
        height: root.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: root.bottom
        anchors.bottomMargin: 0.5
        color: "black"
        opacity: 0.2
    }

    TextShadow {
        id: date_txt
        width: parent.width
        text: current.day
        size: 16
        anchors.centerIn: date_txt_containter
    }
}
