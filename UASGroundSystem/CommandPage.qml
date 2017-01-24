import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtPositioning 5.5
import QtLocation 5.6

Item {
    width: 1200
    height: 900
    property alias label: label
    id:rootItem



    ColumnLayout{
        id:rootLayout
        width: 1200
        anchors.fill: parent

        Connections {
            target: ROSController


            onMessageReceived: {
                messageText.text = message


            }
        }
        Rectangle {
            id:titleRect
            anchors.topMargin: 20
            anchors.bottomMargin: 20
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 100
            radius: 10
            gradient: Gradient {
                GradientStop { position: 0.0; color: "black" }
                GradientStop { position: 1.0; color: "grey" }
            }


            Label {
                anchors.centerIn: parent
                id: label
                text: qsTr("Commands")
                font.pointSize: 28
                color: "white"

            }


        }

        Rectangle {
            id:commandButtonsRect
            anchors.top: titleRect.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 10
            width: parent.width
            height: parent.height*0.75
            gradient: Gradient {
                GradientStop { position: 0.0; color: "black" }
                GradientStop { position: 1.0; color: "grey" }
            }

            ColumnLayout {
                anchors.top: commandButtonsRect.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter


                Button {
                    anchors.topMargin: 20
                    width: 100
                    height: 50
                    id: gohome
                    text: qsTr("Return Home")
                    font.pointSize: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Button {
                    anchors.topMargin: 20
                    width: 100
                    height: 50
                    id: targetTrackingBtn
                    text: qsTr("Target Tracking")
                    font.pointSize: 10
                    onClicked: {
                        console.log("User clicked the target-tracking button");
                        var component = Qt.createComponent("TargetTracking.qml");
                        var ttView = component.createObject(rootLayout, {"x": 600, "y": 400});


                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Button {
                    anchors.topMargin: 20
                    width: 100
                    height: 50
                    id: payloadControlBtn
                    onClicked: {
                        console.log("User clicked the payload controls button");
                        var component = Qt.createComponent("PayloadControls.qml");
                        var pcView = component.createObject(rootLayout, {"x": 600, "y": 400});

                    }
                    text: qsTr("Payload Control")
                    font.pointSize: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    anchors.topMargin: 20
                    width: 100
                    height: 50
                    id: messageText
                    text: qsTr("No messages yet")
                    font.pointSize: 10
                    color: "yellow"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: messageText.bottom
                    anchors.topMargin: 30
                    id: commandRect
                    height: 400
                    width: 400
                    color: "green"
/*
                    Button {
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Up")

                        onClicked: {

                            ROSController.sendCommand("(4.763f,5.3675f)");

                        }
                    }

                    Button {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Left")

                    }
                    Button {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Right")

                    }

                    Button {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Down")

                    }
*/

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var my_x = mouse.x * 0.025;
                            var my_y = 10.0 - (mouse.y * 0.025);
                            testLbl.text = qsTr("x: " + my_x + ", y:"+my_y);
                            ROSController.sendCommand("("+my_x+","+my_y+",3.82342)");
                        }
                    }
                }
                Label {
                    anchors.top: commandRect.bottom
                    color: "yellow"
                    id:testLbl
                    text: "no coords yet"
                }

            }
            Button {
                anchors.bottom: commandButtonsRect.bottom
                id: getMessageButton
                text: qsTr("Send Command")
                onClicked: {

                    ROSController.getMessage();

                }
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 20
            }

        }




    }







}
