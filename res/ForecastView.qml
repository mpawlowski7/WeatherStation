import weatherstation.gui 1.0

import QtQuick 2.7
import QtQml 2.2

Rectangle {
    id: root
    width: parent.width / 3
    height: parent.height
    anchors.verticalCenter: parent.verticalCenter
    clip: true

    ListView {
        id: forecast_list
        anchors.fill: parent
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 250
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds

        property bool r_arrow: true
        property bool l_arrow: false
        property string period: ""
        property var week: ["", "", ""]

        onMovementStarted: {
            r_arrow = false;
            l_arrow= false;
        }
        onMovementEnded: {
            if(currentIndex === 0) {
                r_arrow = true;
                l_arrow = false;
            }
            else if(currentIndex === count-1) {
                r_arrow= false;
                l_arrow = true;
            }
            else {
                r_arrow = true;
                l_arrow= true;
            }
            period = week[currentIndex];
        }

        model: ListModel {
            id: forecast_list_model
            property bool roomListModelCompleted: false
            Component.onCompleted: {
                append ({
                            "pDay_1": "jutro",
                            "pIcon_1": GuiPainter.forecast["icon"][0],
                            "pCondition_1": GuiPainter.forecast["conditions"][0],
                            "pTempHigh_1": GuiPainter.forecast["temp_high"][0],
                            "pTempLow_1": GuiPainter.forecast["temp_low"][0],
                            "pDay_2": "pojutrze",
                            "pIcon_2": GuiPainter.forecast["icon"][1],
                            "pCondition_2": GuiPainter.forecast["conditions"][1],
                            "pTempHigh_2": GuiPainter.forecast["temp_high"][1],
                            "pTempLow_2": GuiPainter.forecast["temp_low"][1],
                            "pDay_3": GuiPainter.forecast["date"][2].toLocaleDateString(Qt.locale(), "dddd dd.MM"),
                            "pIcon_3": GuiPainter.forecast["icon"][2],
                            "pCondition_3": GuiPainter.forecast["conditions"][2],
                            "pTempHigh_3": GuiPainter.forecast["temp_high"][2],
                            "pTempLow_3": GuiPainter.forecast["temp_low"][2]
                        });
                forecast_list.week[0] = GuiPainter.forecast["date"][0].toLocaleDateString(Qt.locale(), "dd.MM") + " - " + GuiPainter.forecast["date"][2].toLocaleDateString(Qt.locale(), "dd.MM");
                for(var i=3; i<9; i=i+3) {
                    append ({
                                "pDay_1": GuiPainter.forecast["date"][i].toLocaleDateString(Qt.locale(), "dddd dd.MM"),
                                "pIcon_1": GuiPainter.forecast["icon"][i],
                                "pCondition_1": GuiPainter.forecast["conditions"][i],
                                "pTempHigh_1": GuiPainter.forecast["temp_high"][i],
                                "pTempLow_1": GuiPainter.forecast["temp_low"][i],
                                "pDay_2": GuiPainter.forecast["date"][i+1].toLocaleDateString(Qt.locale(), "dddd dd.MM"),
                                "pIcon_2": GuiPainter.forecast["icon"][i+1],
                                "pCondition_2": GuiPainter.forecast["conditions"][i+1],
                                "pTempHigh_2": GuiPainter.forecast["temp_high"][i+1],
                                "pTempLow_2": GuiPainter.forecast["temp_low"][i+1],
                                "pDay_3": GuiPainter.forecast["date"][i+2].toLocaleDateString(Qt.locale(), "dddd dd.MM"),
                                "pIcon_3": GuiPainter.forecast["icon"][i+2],
                                "pCondition_3": GuiPainter.forecast["conditions"][i+2],
                                "pTempHigh_3": GuiPainter.forecast["temp_high"][i+2],
                                "pTempLow_3": GuiPainter.forecast["temp_low"][i+2]
                            });
                    forecast_list.week[i/3] = GuiPainter.forecast["date"][i].toLocaleDateString(Qt.locale(), "dd.MM") + " - " + GuiPainter.forecast["date"][i+2].toLocaleDateString(Qt.locale(), "dd.MM");
                }
                roomListModelCompleted = true;
                forecast_list.period = forecast_list.week[0];
            }
        }

        delegate: Column {
            id: forecast_list_delegate
            width: root.width
            height: root.height * 0.85
            padding: 5
            spacing: 5

            SingleDayView {
                width: forecast_list_delegate.width
                height: forecast_list_delegate.height / 3
                day: pDay_1
                icon: pIcon_1
                condition: pCondition_1
                tempHigh: pTempHigh_1
                tempLow: pTempLow_1
            }

            SingleDayView {
                width: forecast_list_delegate.width
                height: forecast_list_delegate.height / 3
                day: pDay_2
                icon: pIcon_2
                condition: pCondition_2
                tempHigh: pTempHigh_2
                tempLow: pTempLow_2
            }

            SingleDayView {
                width: forecast_list_delegate.width
                height: forecast_list_delegate.height / 3
                day: pDay_3
                icon: pIcon_3
                condition: pCondition_3
                tempHigh: pTempHigh_3
                tempLow: pTempLow_3
            }
        }
        Rectangle {
            width: parent.width
            height: parent.height * 0.15
            color: "#00c7b3"
            anchors.bottom: parent.bottom

            TextShadow {
                id: room_l_arrow;
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                text: awesome.icons.fa_arrow_circle_left
                visible: forecast_list.l_arrow
            }

            TextShadow {
                shadowVisible: false
                textColor: "#ffffff"
                text: forecast_list.period
                size: 14
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            TextShadow {
                id: room_r_arrow;
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                text: awesome.icons.fa_arrow_circle_right
                visible: forecast_list.r_arrow
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

    function updateData() {
        if(forecast_list_model.roomListModelCompleted && forecast_list_model.count > 0) {
            forecast_list.period = forecast_list.week[forecast_list.currentIndex];
            forecast_list_model.setProperty(
                        0, "pDay_1", "jutro",
                        "pIcon_1", GuiPainter.forecast["icon"][0],
                        "pCondition_1", GuiPainter.forecast["conditions"][0],
                        "pTempHigh_1", GuiPainter.forecast["temp_high"][0],
                        "pTempLow_1", GuiPainter.forecast["temp_low"][0],
                        "pDay_2", "pojutrze",
                        "pIcon_2", GuiPainter.forecast["icon"][1],
                        "pCondition_2", GuiPainter.forecast["conditions"][1],
                        "pTempHigh_2", GuiPainter.forecast["temp_high"][1],
                        "pTempLow_2", GuiPainter.forecast["temp_low"][1],
                        "pDay_3", GuiPainter.forecast["date"][2].toLocaleDateString(Qt.locale(), "dddd dd.MM"),
                        "pIcon_3", GuiPainter.forecast["icon"][2],
                        "pCondition_3", GuiPainter.forecast["conditions"][2],
                        "pTempHigh_3", GuiPainter.forecast["temp_high"][2],
                        "pTempLow_3", GuiPainter.forecast["temp_low"][2]);
            forecast_list.week[0] = GuiPainter.forecast["date"][0].toLocaleDateString(Qt.locale(), "dd.MM") + " - " + GuiPainter.forecast["date"][2].toLocaleDateString(Qt.locale(), "dd.MM");
            for(var i=3; i<9; i=i+3) {
                forecast_list_model.setProperty(
                            i/3, "pDay_1", GuiPainter.forecast["date"][i].toLocaleDateString(Qt.locale(), "dddd dd.MM"),
                            "pIcon_1", GuiPainter.forecast["icon"][i],
                            "pCondition_1", GuiPainter.forecast["conditions"][i],
                            "pTempHigh_1", GuiPainter.forecast["temp_high"][i],
                            "pTempLow_1", GuiPainter.forecast["temp_low"][i],
                            "pDay_2", GuiPainter.forecast["date"][i+1].toLocaleDateString(Qt.locale(), "dddd dd.MM"),
                            "pIcon_2", GuiPainter.forecast["icon"][i+1],
                            "pCondition_2", GuiPainter.forecast["conditions"][i+1],
                            "pTempHigh_2", GuiPainter.forecast["temp_high"][i+1],
                            "pTempLow_2", GuiPainter.forecast["temp_low"][i+1],
                            "pDay_3", GuiPainter.forecast["date"][i+2].toLocaleDateString(Qt.locale(), "dddd dd.MM"),
                            "pIcon_3", GuiPainter.forecast["icon"][i+2],
                            "pCondition_3", GuiPainter.forecast["conditions"][i+2],
                            "pTempHigh_3", GuiPainter.forecast["temp_high"][i+2],
                            "pTempLow_3", GuiPainter.forecast["temp_low"][i+2]
                            );
                forecast_list.week[i/3] = GuiPainter.forecast["date"][i].toLocaleDateString(Qt.locale(), "dd.MM") + " - " + GuiPainter.forecast["date"][i+2].toLocaleDateString(Qt.locale(), "dd.MM");
            }
//            if(forecast_list.period !== forecast_list.week[forecast_list.currentIndex]) {
//                forecast_list.period = forecast_list.week[forecast_list.currentIndex];
//            }
        }
    //    if(!forecast_list.dragging && !forecast_list.flicking) {
      //      forecast_list.flick(1000, 0);
       //     while(forecast_list.flicking) { console.log("dupa") }
 //       }
    }

    function goToStart() {

    }
}
