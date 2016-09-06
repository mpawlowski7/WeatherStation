import QtQuick 2.0

Item {

    readonly property var arr: new Array

    Colors {
        id: colors;
    }


    Grid {
        id: grid
        anchors.horizontalCenter: parent.horizontalCenter
        rows: 8; columns: 8
        columnSpacing: 5; rowSpacing: 5
        Component.onCompleted: {
            var component = Qt.createComponent("Pixel.qml");
            var j=1
            for (var i = 0; i<64; i++) {
                var object = component.createObject(grid);
                object.color = colors.rainbow[i];
                arr.push(object);
                //               switch(true) {
                //               case (i<8):
                //                   object.color = Qt.rgba(1, (1*j*32)/255, 0, 1);
                //                   break;
                //               case (i>=8 && i<16):
                //                   object.color = Qt.rgba((1*j*32)/255, 1, 0, 1);
                //                   break;
                //               case (i>=16 && i<24):
                //                   object.color = Qt.rgba(0, (1*j*32)/255, 1, 1);
                //                   break;
                //               case (i>=24 && i<32):
                //                   object.color = Qt.rgba(1, 0, (1*j*32)/255, 1);
                //                   break;
                //               case (i>=32 && i<40):
                //                   object.color = Qt.rgba((1*j*32)/255, 0, 1, 1);
                //                   break;
                //               case (i>=40 && i<48):
                //                   object.color = Qt.rgba(1, (1*j*32)/255, 0, 1);
                //                   break;
                //               case (i>=48 && i<56):
                //                   object.color = Qt.rgba(1, (1*j*32)/255, 0, 1);
                //                   break;
                //               case (i>=56 && i<64):
                //                   object.color = Qt.rgba(1, (1*j*32)/255, 0, 1);
                //                   break;
                //               }
                //               j++;
                //               if(j==9)
                //               {
                //                   j=1;
                //               }
            }
        }
    }

}
