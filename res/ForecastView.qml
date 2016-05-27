import weatherstation.gui 1.0

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

ScrollView {
    id: forecast
    anchors.fill: parent
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    flickableItem.interactive: true
    flickableItem.flickableDirection: Flickable.VerticalFlick

    property date today: new Date()

    property real contentHeight: parent.height

    Column {
        id: wrapper
        width: parent.width
        height: contentHeight * 7
        spacing: 0

        SingledayView {
            id: per_0
            width: forecast.width
            height: forecast.height
            day: GuiPainter.forecast["date"][0]
            icon: GuiPainter.forecast["icon"][0]
            condition: GuiPainter.forecast["conditions"][0]
            tempHigh: GuiPainter.forecast["temp_high"][0]
            tempLow: GuiPainter.forecast["temp_low"][0]

            Component.onCompleted: {
                console.log("per_0 icon: " + icon)
            }
        }


        SingledayView {
            id: per_1
            width: forecast.width
            height: forecast.height
            day: GuiPainter.forecast["date"][1]
            icon: GuiPainter.forecast["icon"][1]
            condition: GuiPainter.forecast["conditions"][1]
            tempHigh: GuiPainter.forecast["temp_high"][1]
            tempLow: GuiPainter.forecast["temp_low"][1]

        }

        SingledayView {
            id: per_2
            width: forecast.width
            height: forecast.height
            day: GuiPainter.forecast["date"][2]
            icon: GuiPainter.forecast["icon"][2]
            condition: GuiPainter.forecast["conditions"][2]
            tempHigh: GuiPainter.forecast["temp_high"][2]
            tempLow: GuiPainter.forecast["temp_low"][2]
        }

        SingledayView {
            id: per_3
            width: forecast.width
            height: forecast.height
            day: GuiPainter.forecast["date"][3]
            icon: GuiPainter.forecast["icon"][3]
            condition: GuiPainter.forecast["conditions"][3]
            tempHigh: GuiPainter.forecast["temp_high"][3]
            tempLow: GuiPainter.forecast["temp_low"][3]
        }

        SingledayView {
            id: per_4
            width: forecast.width
            height: forecast.height
            day: GuiPainter.forecast["date"][4]
            icon: GuiPainter.forecast["icon"][4]
            condition: GuiPainter.forecast["conditions"][4]
            tempHigh: GuiPainter.forecast["temp_high"][4]
            tempLow: GuiPainter.forecast["temp_low"][4]
        }

        SingledayView {
            id: per_5
            width: forecast.width
            height: forecast.height
            day: GuiPainter.forecast["date"][5]
            icon: GuiPainter.forecast["icon"][5]
            condition: GuiPainter.forecast["conditions"][5]
            tempHigh: GuiPainter.forecast["temp_high"][5]
            tempLow: GuiPainter.forecast["temp_low"][5]
        }

        SingledayView {
            id: per_6
            width: forecast.width
            height: forecast.height
            day: GuiPainter.forecast["date"][6]
            icon: GuiPainter.forecast["icon"][6]
            condition: GuiPainter.forecast["conditions"][6]
            tempHigh: GuiPainter.forecast["temp_high"][6]
            tempLow: GuiPainter.forecast["temp_low"][6]
        }
    }

    function fill10DayForecast()
    {
   //     component = Qt.createComponent("SingledayView.qml");
        for(var i=0; i<10; i++)
        {
            component = Qt.createComponent("SingledayView.qml");
        }
    }
}
