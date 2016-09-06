import weatherstation.gui 1.0

import QtQuick 2.7
import QtQml 2.2

Rectangle {
    id: root
    width: parent.width / 3
    height: parent.height
    anchors.verticalCenter: parent.verticalCenter
    color: "transparent"

    Rectangle {
        width: parent.width
        height: parent.height * 0.49
        anchors.top: parent.top
        color: "#00b499"

        Item {
            width: parent.width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                width: parent.width
                height: parent.height * 0.1
                anchors.top: parent.top

                TextShadow {
                    text: awesome.icons.fa_clock_o
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                }

                TextShadow {
                    text: "UTC+0"+(-(new Date().getTimezoneOffset()/60))+":00"
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                }
            }

            TextShadow {
                id: time_txt
                anchors.centerIn: parent
                text: GuiPainter.currentDateTime["time"]
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -parent.height * 0.1
                size: 46
            }

            Rectangle {
                width: parent.width
                height: parent.height * 0.3
                anchors.bottom: parent.bottom
                color: "#00b499"

                TextShadow {
                    id: clock_txt;
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: GuiPainter.currentDateTime["date"]
                    size: 16
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
    }

    Rectangle {
        id: sensorsIn
        width: parent.width
        height: parent.height * 0.49
        anchors.bottom: parent.bottom
        color: "#a7c629"
        clip: true

        ListView {
            id: room_list
            anchors.fill: parent
            snapMode: ListView.SnapOneItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            highlightMoveDuration: 250
            orientation: ListView.Horizontal
            boundsBehavior: Flickable.StopAtBounds

            property bool r_arrow: true
            property bool l_arrow: false

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
            }

            model: ListModel {
                id: room_list_model
                property bool roomListModelCompleted: false
                Component.onCompleted: {
                    append ({"room": "Biuro", "temp": GuiPainter.temperature, "humidity": GuiPainter.humidity});
                    append ({"room": "Sypialnia", "temp": GuiPainter.temperature, "humidity": GuiPainter.humidity});
                    append ({"room": "Salon", "temp": GuiPainter.temperature, "humidity": GuiPainter.humidity});
                    append ({"room": "Kuchnia", "temp": GuiPainter.temperature, "humidity": GuiPainter.humidity});
                    append ({"room": "Dziecięcy", "temp": GuiPainter.temperature, "humidity": GuiPainter.humidity});
                    roomListModelCompleted = true;
                }
            }

            delegate: Item {
                id: room_delegate
                width: sensorsIn.width
                height: sensorsIn.height

                Item {
                    width: parent.width
                    height: parent.height * 0.1
                    anchors.top: parent.top

                    TextShadow {
                        id: batteryOut_txt
                        text: awesome.icons.fa_battery_full
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                    }

                    TextShadow {
                        id: signalOut_txt
                        text: awesome.icons.fa_signal
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                    }
                }

                TextShadow { id: temperature_txt;
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -parent.height * 0.22
                    text: temp + qsTr("\u00B0")
                    size: 38
                }

                Row {
                    spacing: 5
                    anchors.top: temperature_txt.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    WeatherIcon {
                        id: humidityIn_ico;
                        anchors.verticalCenter: parent.verticalCenter
                        type: "humidity"
                        size: 12
                    }

                    TextShadow {
                        id: humidityIn_txt
                        text: humidity + qsTr("%")
                        anchors.verticalCenter: parent.verticalCenter
                        size: 12
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height * 0.3
                    anchors.bottom: parent.bottom
                    color: "#a7c629"

                    TextShadow {
                        id: room_l_arrow;
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: awesome.icons.fa_arrow_circle_left
                        visible: room_list.l_arrow
                    }

                    TextShadow {
                        id: room_txt;
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: room
                        size: 14
                    }

                    TextShadow {
                        id: room_r_arrow;
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: awesome.icons.fa_arrow_circle_right
                        visible: room_list.r_arrow
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
        }
    }

    function updateData() {
        if(room_list_model.roomListModelCompleted) {
            for(var i=0; i<5; i++) {
                room_list_model.setProperty(i, "temp", GuiPainter.temperature);
                room_list_model.setProperty(i, "humidity", GuiPainter.humidity);
            }
        }
    }
}

