import QtQuick 2.7
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2



Item {
    Dialog {
        visible: true
        title: "Payload Controls"

        contentItem: Rectangle {
            color: "grey"
            implicitWidth: 600
            implicitHeight: 400

            ColumnLayout {
                anchors.fill: parent
                width: parent.implicitWidth


                Button {
                    anchors.margins: 10
                    text: qsTr("Payload 1")
                    anchors.horizontalCenter: parent.horizontalCenter
                    style: ButtonStyle {
                        background:  Rectangle {
                            implicitWidth: 200
                            implicitHeight: 80
                            color: "white"
                        }

                        label: Text {
                            renderType: Text.NativeRendering
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            font.pointSize: 20
                            color: "black"
                            text: control.text
                        }
                    }

                }

                Button {
                    anchors.margins: 10
                    text: qsTr("Payload 2")
                    anchors.horizontalCenter: parent.horizontalCenter
                    style: ButtonStyle {
                        background:  Rectangle {
                            implicitWidth: 200
                            implicitHeight: 80
                            color: "white"
                        }

                        label: Text {
                            renderType: Text.NativeRendering
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            font.pointSize: 20
                            color: "black"
                            text: control.text
                        }
                    }



                }

                Button {
                    anchors.margins: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Payload 3")
                    style: ButtonStyle {
                        background:  Rectangle {
                            implicitWidth: 200
                            implicitHeight: 80
                            color: "white"
                        }

                        label: Text {
                            renderType: Text.NativeRendering
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Helvetica"
                            font.pointSize: 20
                            color: "black"
                            text: control.text
                        }
                    }

                }

            }

        }
    }

}
