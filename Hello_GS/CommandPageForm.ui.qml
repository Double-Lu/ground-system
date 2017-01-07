import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Item {
    property alias button2: button2
    property alias button1: button1
    property alias button: button
    property alias rectangle: rectangle
    property alias rectangle1: rectangle1
    property alias comboBox: comboBox
    property alias button3: button3

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

        Button {
            id: button
            x: 190
            y: 39
            text: qsTr("Return to Base")
            autoRepeat: false
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: true
        }

        Button {
            id: button1
            x: 190
            y: 140
            text: qsTr("Target-Tracking")
            highlighted: true
        }

        Button {
            id: button2
            x: 190
            y: 239
            text: qsTr("Payload Control")
            highlighted: true
        }
    }

    Connections {
        target: button
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

            ComboBox {
                id: comboBox
                x: 148
                y: 58
                width: 232
                height: 241
                visible: true
                currentIndex: -1
                textRole: ""
            }
        }
    }

    Connections {
        target: button3
        onClicked: print("exit window")
    }
}
