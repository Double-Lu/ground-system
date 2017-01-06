import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Item {
    width: 400
    height: 400
    id:rootItem
    default property alias content: pane.contentItem

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent.top
        anchors.fill: parent
        anchors.bottomMargin: 20

        Connections {
            target: ROSController

            onMessageReceived: {
                messageText.text = message

            }
        }


        Flickable {
            anchors.fill: parent
            anchors.top:machineHealthTitle.bottom
            contentHeight: pane.implicitHeight
            flickableDirection: Flickable.AutoFlickIfNeeded

            Pane {
                id: pane
                width: parent.width
                height: parent.height
                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 20
                    anchors.top: parent.top
                    anchors.fill: parent
                    anchors.bottomMargin: 20

                    Text {
                        id: messageText
                        text: qsTr("No machine data yet...")
                    }

                    Text {
                        id: messageText2
                        text: qsTr("No machine data yet...")
                    }

                    Text {
                        id: messageText3
                        text: qsTr("No machine data yet...")
                    }
                }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
        Label {
            text: qsTr("Machine Health")
            id: machineHealthTitle
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }


    }

}
