import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.WebSockets 1.0
import QtMultimedia 5.5
import CVCamera 1.0

Item {
    width: 400
    height: 400

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent.top



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
}
