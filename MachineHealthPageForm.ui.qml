import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Item {
    width: 1200
    height: 900
    id: rootItem
    property alias payloadHealth1Btn: payloadHealth1Btn
    property alias rootLayout: rootLayout
    property alias fuelGauge: fuelGauge

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent.top
        anchors.fill: parent
        anchors.bottomMargin: 20
        id:rootLayout
        width: 1200
        height: 900

        Connections {
            target: ROSController

            //            onMessageReceived: {
            //                messageText.text = message

            //            }
        }

        Rectangle {
            anchors.topMargin: 20
            anchors.bottomMargin: 20
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            id: titleRect
            width: 300
            height: 100
            radius: 10
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#ffffff"
                }
                GradientStop {
                    position: 1.0
                    color: "grey"
                }
            }

            Label {
                anchors.centerIn: parent
                id: label
                text: qsTr("Machine Health")
                font.pointSize: 28
                color: "white"
            }
        }

        RowLayout {
            anchors.top: titleRect.bottom
            anchors.topMargin: 20
            width: parent.width
            height: parent.height * 0.8

            Rectangle {
                border.color: "black"
                anchors.left: parent.left
                height: parent.height * 0.75
                width: parent.width / 2
                id: overallHealthRect
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "#2c3e50"
                    }
                    GradientStop {
                        position: 1.0
                        color: "grey"
                    }
                }

                Gauge {
                    minimumValue: 0
                    value: 50
                    maximumValue: 100
                    anchors.centerIn: parent
                    id: fuelGauge

                }
            }
            Rectangle {
                anchors.left: overallHealthRect.right
                border.color: "black"
                height: parent.height * 0.75
                width: parent.width / 2
                id:plHealthBtnRect
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "#2c3e50"
                    }
                    GradientStop {
                        position: 1.0
                        color: "grey"
                    }
                }

                ColumnLayout {
                    anchors.top: plHealthBtnRect.top
                    anchors.topMargin: 20
                    anchors.centerIn: parent



                    Button {
                        anchors.topMargin: 20
                        width: 100
                        height: 50
                        text: qsTr("Payload 1 Health")
                        id: payloadHealth1Btn
                        font.pointSize: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        anchors.topMargin: 20
                        width: 100
                        height: 50
                        id: payloadHealth2Btn
                        text: qsTr("Payload 2 Health")
                        font.pointSize: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        anchors.topMargin: 20
                        width: 100
                        height: 50
                        id: payloadHealth3Btn
                        text: qsTr("Payload 3 Health")
                        font.pointSize: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                }
            }
        }
    }
}
