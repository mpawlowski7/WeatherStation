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
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOn
        flickableItem.interactive: true
        flickableItem.flickableDirection: Flickable.VerticalFlick
        flickableItem.boundsBehavior: Flickable.DragAndOvershootBounds

        property date today: new Date()
        property real contentHeight: root.height
        //    contentItem: wrapper


        flickableItem.onFlickStarted: {
            //       date_txt.visible = false
        }

        flickableItem.onFlickEnded: {
            console.log(contentItem.children[Math.round(flickableItem.contentY/scroll.height)].condition+": "
                        +contentItem.children[Math.round(flickableItem.contentY/scroll.height)].icon);
            //     flickableItem.contentY = scroll.height * Math.round(flickableItem.contentY/scroll.height);
            //   date_txt.text = contentItem.children[Math.round(flickableItem.contentY/scroll.height)].day;
            //  date_txt.visible = true;
        }

        Column {
            id: wrapper
            width: root.width
            height: scroll.contentHeight * 3.1
            spacing: 3
            anchors.top: parent.top

            Component.onCompleted: {
                fill10DayForecast();
            }

            //            SingleDayView {
            //                id: current
            //                width: scroll.width
            //                height: scroll.height * 0.3
            //                day: "Aktualnie"
            //                icon: GuiPainter.currentWeather["icon"]
            //                condition: GuiPainter.currentWeather["weather"]
            //                tempHigh: GuiPainter.currentWeather["temp_c"]
            //                tempLow: ""

            //                Component.onCompleted: {
            //                    console.log("Current weather icon: " + icon)
            //                }
            //            }

            function fill10DayForecast() {
                var component = Qt.createComponent("SingleDayView.qml");
                if (component.status === Component.Ready) {
                    for(var i=1; i<10; i++) {
                        var singleDay =  component.createObject(wrapper,
                                                                { "objectName": "per_"+i,
                                                                    "id": "per_"+i,
                                                                    "width": scroll.width,
                                                                    "height": scroll.height * 0.34,
                                                                    "day": GuiPainter.forecast["date"][i],
                                                                    "icon": GuiPainter.forecast["icon"][i],
                                                                    "condition": GuiPainter.forecast["conditions"][i],
                                                                    "tempHigh": GuiPainter.forecast["temp_high"][i],
                                                                    "tempLow": GuiPainter.forecast["temp_low"][i]
                                                                });
                        //        singleDay.doubleClick.connect(goToStart);
                    }
                }
            }

            function goToStart() {
                console.log("Going to start");
                //     while(scroll.flickableItem.contentY != 0)
                scroll.flickableItem.contentY = 0;
                //     date_txt.text = current.day;
            }


        }

        style: ScrollViewStyle {
            handleOverlap: 0
            handle: Item {
                implicitWidth: scroll.width * 0.03
                implicitHeight: scroll.height * 0.34
                Rectangle {
                    color: "white"
                    opacity: 1
                    anchors.fill: parent
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                }
            }
            scrollBarBackground: Rectangle {
                implicitWidth: scroll.width * 0.03
                implicitHeight: scroll.height * 0.34
                color: "white"
                opacity: 0.3
            }
            incrementControl: Item { }
            decrementControl: Item { }
        }
    }



    //    Rectangle {
    //        id: date_txt_containter
    //        width: root.width
    //        height: root.height * 0.1
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        anchors.bottom: root.bottom
    //        anchors.bottomMargin: 0.5
    //        color: "black"
    //        opacity: 0.2
    //    }

    //    TextShadow {
    //        id: date_txt
    //        width: parent.width
    //        text: current.day
    //        size: 16
    //        anchors.centerIn: date_txt_containter
    //    }
}
