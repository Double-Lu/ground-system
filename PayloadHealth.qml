import QtQuick 2.7
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2



Item {
    Dialog {
        visible: true
        title: "Payload Health"

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


                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    id: image
                    width: 100
                    height: 100
                    source: "indicator.png"
                }


            }

        }
    }

}
