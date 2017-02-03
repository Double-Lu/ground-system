import QtQuick 2.7
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4



Item {
    Dialog {
        visible: true
        title: "Payload Health"

        Connections {
            target: ROSController


            onMessageReceived: {
                console.log('in PayloadHealth onMessageReceived...');
                var messagePieces = message.split(',');
                var x = parseFloat(messagePieces[0]);
                var y = parseFloat(messagePieces[1]);
                var z = parseFloat(messagePieces[2]);

                console.log('I parsed ' + x + ', ' + y + ', ' + z + ' from ' + message);
                //messageText.text = message
                testGauge.value = x * 10.0;


            }
        }

        contentItem: Rectangle {
            color: "grey"
            implicitWidth: 600
            implicitHeight: 400

            ColumnLayout {
                anchors.fill: parent
                width: parent.implicitWidth

                Label {
                    font.pointSize: 30
                    text: qsTr("Payload Health")
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                CircularGauge {
                    id: testGauge
                    anchors.horizontalCenter: parent.horizontalCenter

                    Behavior on value {
                        NumberAnimation {
                            duration: 1000
                        }
                    }

                    style: CircularGaugeStyle {
                        needle: Rectangle {
                            y: outerRadius * 0.15
                            implicitWidth: outerRadius * 0.03
                            implicitHeight: outerRadius * 0.9
                            antialiasing: true
                            color: Qt.rgba(0.66, 0.3, 0, 1)
                        }
                    }
                }

//                Image {
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    id: image
//                    width: 100
//                    height: 100
//                    source: "indicator.png"
//                }


            }

        }
    }

}
