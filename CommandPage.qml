import QtQuick 2.7

CommandPageForm {
    getMessageButton.onClicked: {

        ROSController.getMessage();

    }

    payloadControlBtn.onClicked: {
        console.log("User clicked the payload controls button");
        var component = Qt.createComponent("PayloadControls.qml");
        var pcView = component.createObject(rootLayout, {"x": 600, "y": 400});

    }
    targetTrackingBtn.onClicked: {
        console.log("User clicked the target-tracking button");
        var component = Qt.createComponent("TargetTracking.qml");
        var ttView = component.createObject(rootLayout, {"x": 600, "y": 400});

    }
}
