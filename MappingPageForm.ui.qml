import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.WebSockets 1.0
import QtMultimedia 5.5

Item {
    width: 400
    height: 400
    property alias cvImage: cvImage

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent.top


    }
}
