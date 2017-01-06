import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtMultimedia 5.0
import CVCamera 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    id: window
    RowLayout {

    }

    Label {
        id:titleLabel
        text: "UAS Ground System"
        anchors.top: window.top
        anchors.horizontalCenter: parent.horizontalCenter
    }


    SwipeView {
        id: swipeView
        anchors.top: titleLabel.bottom
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        /*Page1 {
        }*/

        CommandPage {

        }

        Page {




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

        Page {
            Label {
                text: qsTr("Machine Health Page")
                anchors.centerIn: parent
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Command")
        }
        TabButton {
            text: qsTr("Mapping")
        }
        TabButton {
            text: qsTr("Machine Health")
        }
    }
}
