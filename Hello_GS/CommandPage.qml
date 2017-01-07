import QtQuick 2.7

CommandPageForm{
    button2.onClicked: {
        rectangle1.visible = true
    }
    button3.onClicked: {
        rectangle1.visible = false
    }
}
