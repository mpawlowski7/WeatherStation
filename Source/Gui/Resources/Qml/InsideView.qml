import weatherstation.gui 1.0

import QtQuick 2.7
import QtQml 2.2

Rectangle {
    id: root
    anchors.verticalCenter: parent.verticalCenter
    color: "transparent"

    Rectangle {
        width: parent.width
        height: parent.height * 0.49
        anchors.top: parent.top
        color: "#02443a"
        border.color: "#037362"
        border.width: parent.width * 0.02

        Item {
            width: parent.width
            height: parent.height * 0.49
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                width: parent.width * 0.9
                height: parent.height * 0.4
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                TextShadow {
                    text: awesome.icons.fa_clock_o
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextShadow {
                    text: "UTC+0"+(-(new Date().getTimezoneOffset()/60))+":00"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Item {
                width: parent.width
                height: parent.height * 0.3
                anchors.bottom: parent.bottom

                TextShadow {
                    id: time_txt
                    text: GuiPainter.currentDateTime["time"]
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: parent.height * 0.3
                    size: 52
                }
                TextShadow {
                    id: date_txt;
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: time_txt.bottom
                    anchors.topMargin: -parent.height * 0.2
                    text: GuiPainter.currentDateTime["date"]
                    size: 14
                }
            }
        }
    }

    Rectangle {
        id: sensorsIn
        width: parent.width
        height: parent.height * 0.49
        anchors.bottom: parent.bottom
        color: "#22404a"
        clip: true
        border.color: "#356373"
        border.width: parent.width * 0.02

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
                    width: parent.width * 0.9
                    height: parent.height * 0.2
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter

                    TextShadow {
                        id: batteryOut_txt
                        text: awesome.icons.fa_battery_full
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextShadow {
                        id: signalOut_txt
                        text: awesome.icons.fa_signal
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                TextShadow {
                    id: temperature_txt;
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -parent.height * 0.15
                    text: temp + qsTr("\u00B0")
                    size: 38
                }

                Row {
                    spacing: 5
                    anchors.top: temperature_txt.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: -parent.height * 0.05

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
                    color: "#356373"

                    TextShadow {
                        id: room_l_arrow;
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.08
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
                        anchors.rightMargin: parent.width * 0.08
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

