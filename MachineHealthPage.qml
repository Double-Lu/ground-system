import QtQuick 2.4

MachineHealthPageForm {
    payloadHealth1Btn.onClicked: {

        console.log("User clicked the Payload 1's button");
        var component = Qt.createComponent("PayloadHealth.qml");
        var plhView = component.createObject(rootLayout, {"x": 600, "y": 400});
    }
}
