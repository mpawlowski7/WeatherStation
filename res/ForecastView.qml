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
        anchors.fill: root
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        flickableItem.interactive: true
        flickableItem.flickableDirection: Flickable.VerticalFlick

        property date today: new Date()

        property real contentHeight: root.height
        Component.onCompleted: {
            console.log("contentHeight: " + contentHeight)
        }

        Column {
            id: wrapper
            width: root.width
            height: scroll.contentHeight * 10
            spacing: 0

            Component.onCompleted: {
                fill10DayForecast();
            }

            function fill10DayForecast()
            {
                var component = Qt.createComponent("SingledayView.qml");
                if (component.status === Component.Ready)
                {
                    for(var i=0; i<10; i++)
                    {
                        component.createObject(wrapper,
                                               { "id": "per_"+i,
                                                 "width": scroll.width,
                                                 "height": scroll.height,
                                                 "day": GuiPainter.forecast["date"][i],
                                                 "icon": GuiPainter.forecast["icon"][i],
                                                 "condition": GuiPainter.forecast["conditions"][i],
                                                 "tempHigh": GuiPainter.forecast["temp_high"][i],
                                                 "tempLow": GuiPainter.forecast["temp_low"][i]
                                               });
                    }
                }
            }
        }

    }
}
