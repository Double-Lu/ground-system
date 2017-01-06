import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Item {
    width: 400
    height: 400
    id:rootItem

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
            text: qsTr("Machine Health")
            anchors.centerIn: parent
        }

        Text {
            id: messageText
            text: qsTr("No machine data yet...")
            anchors.bottom: getMessageButton.top
        }

    }

}
