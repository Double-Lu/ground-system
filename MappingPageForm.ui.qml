import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.WebSockets 1.0
import QtMultimedia 5.5
import CVCamera 1.0

Item {
    width: 1200
    height: 900

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        Rectangle {
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
                text: qsTr("Environments")
                font.pointSize: 28
                color: "white"

            }


        }

        Rectangle {
            width: 800
            height: 600
            anchors.centerIn: parent
            color: "black"
            radius: 10

            CVCamera {
                id: camera
                device: deviceBox.currentIndex
                size: "640x480"
                anchors.centerIn: parent

            }

            VideoOutput {
                anchors.top: imageSizeField.top
                id: output
                source: camera
                anchors.centerIn: parent

            }

        }





    }


}
