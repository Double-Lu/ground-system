import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Item {
    property alias rectangle: rectangle
    property alias rectangle1: rectangle1
    property alias comboBox: comboBox
    property alias button3: button3
    property alias rectangle2: rectangle2
    property alias button1: button1
    property alias itemDelegate: itemDelegate

    Rectangle {
        id: rectangle
        x: 80
        y: 80
        width: 480
        height: 319
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#96f1fc"
            }

            GradientStop {
                position: 1
                color: "#ffffff"
            }
        }
        z: -1

        ComboBox {
            id: comboBox
            x: 35
            y: 45
            width: 187
            height: 230
            visible: true
            currentIndex: -1
            textRole: ""
        }

        ItemDelegate {
            id: itemDelegate
            x: 290
            y: 45
            width: 150
            height: 230
            text: qsTr("Item Delegate")
        }

        Button {
            id: button1
            x: 79
            y: 65
            text: qsTr("Button")
        }
    }

    Connections {
        target: button1
        onClicked: print("Retruning to Base.")
    }

    Connections {
        target: button1
        onClicked: print("Tracking Target...")
    }

    Connections {
        target: button2
        onClicked: print("new window")
    }

    Rectangle {
        id: rectangle1
        x: 0
        y: 0
        width: 640
        height: 480
        color: "#1d1d1d"
        visible: false
        opacity: 0.75

        Button {
            id: button3
            x: 60
            y: 60
            width: 520
            height: 360
            text: qsTr("Controller")
            opacity: 1
            spacing: 20
            autoRepeat: false
            visible: true
        }

        Rectangle {
            id: rectangle2
            x: 102
            y: 100
            width: 436
            height: 273
            color: "#279ad4"
            border.width: 10
            z: 1
            visible: true
        }
    }

    Connections {
        target: button3
        onClicked: print("exit window")
    }
}
