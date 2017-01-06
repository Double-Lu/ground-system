import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Item {
    width: 400
    height: 400
    property alias label: label
    id:rootItem
    property alias getMessageButton: getMessageButton

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent.top
        anchors.fill: parent

        Connections {
            target: ROSController

            onMessageReceived: {
                messageText.text = message

            }
        }
        Label {
            id: label
            text: qsTr("Commands")
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: messageText
            text: qsTr("nothing yet received")
            anchors.bottom: getMessageButton.top
        }

        Button {
            id: getMessageButton
            text: qsTr("Send Command")
            anchors.bottom: parent.bottom
        }
    }

}
