import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("UAS Ground System")
    id: window
    RowLayout {

    }


    SwipeView {
        id: swipeView
        anchors.top: titleLabel.bottom
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        CommandPage {
        }

        MappingPage {
        }

        MachineHealthPage {

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
