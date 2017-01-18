import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 1200
    height: 900
    title: qsTr("UAS Ground System")
    id: window


    Rectangle {
        width: 1200
        height: 900
        anchors.fill: parent
        color: "#95a5a6"


        SwipeView {
            id: swipeView
            anchors.fill: parent
            currentIndex: tabBar.currentIndex


            CommandPage {

            }

            MappingPage {

            }

            MachineHealthPage {

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
            text: qsTr("Environment")
        }
        TabButton {
            text: qsTr("Machine Health")
        }
    }
}
