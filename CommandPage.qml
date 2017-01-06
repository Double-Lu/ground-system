import QtQuick 2.7

CommandPageForm {
    getMessageButton.onClicked: {

        ROSController.getMessage();
    }

}
