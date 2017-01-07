import QtQuick 2.4

MachineHealthPageForm {
    button1.onClicked: {
        rectangle1.visible = true
    }
    button3.onClicked: {
        rectangle1.visible = false
    }
}
