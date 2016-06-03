import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property string day: new Date().toLocaleDateString(Qt.locale("pl_PL"), "dd.MM")
    property string icon: "clear"
    property string condition: "clear"
    property string tempHigh: "30.0"
    property string tempLow: "15.0"

    signal doubleClick();

    Column {
        id: containter
        anchors.fill: parent
        spacing: 2
        anchors.topMargin: 20

        Item {
            width: parent.width
            height: parent.height * 0.4
            //        anchors.bottom: weather_ico_container.top
            TextShadow { id: forecast_txt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -10
                anchors.verticalCenter: parent.verticalCenter
                text: tempLow != "" ? root.tempLow + "/" + root.tempHigh : root.tempHigh; size: 32 }
            TextShadow { id: forecast_txt_unit; anchors.left: forecast_txt.right; anchors.baseline: forecast_txt.baseline; text: qsTr("\u00B0"); size: 16 }
        }

        Rectangle{
            id: weather_ico_container
            width: parent.width
            height: parent.height * 0.35
            color: "transparent"
            //      radius: 180
            anchors.horizontalCenter: containter.horizontalCenter
            Image {
                sourceSize: Qt.size(parent.width*1.1, parent.width*1.1)
                id: weather_ico
                source: "img/"+root.icon+".svg"
                smooth: true
                visible: false
                anchors.centerIn: weather_ico_container
            }

            DropShadow {
                source: weather_ico
                horizontalOffset: 1
                verticalOffset: 1
                radius: 1
                samples: 4
                color: 'slategray'
                opacity: 1
                anchors.fill: source
            }
        }

        Item {
            width: parent.width
            height: parent.height * 0.15
            //        anchors.top: weather_ico_container.bottom
            TextShadow { id: cond_txt; anchors.centerIn: parent;  text: root.condition; size: 14 }
        }


    }

    MouseArea {
        id: mouseArea
        //     anchors.centerIn: parent
        width: parent.width
        height: parent.height
        onDoubleClicked: {
            root.doubleClick();
            //       scroll.flickableItem.contentY = 0;
            //            date_txt.text = scroll.flickableItem.contentItem.children[Math.round(scroll.flickableItem.contentY/scroll.height)].day;
        }

    }
}
