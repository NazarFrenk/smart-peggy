import QtQuick
import QtQuick.Controls
import smartpeggy

import "../singletons"

Item {
    id: root

    property string text: ""
    property bool active: false
    signal clicked()

    implicitHeight: text.height + line.height + column.spacing
    implicitWidth: text.width

    Column {
        id: column
        anchors.fill: parent
        spacing: 2

        Label {
            id: text
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            text: root.text
            color: Style.neon
            font.pixelSize: FontSize.medium
            fontSizeMode: Text.Fit
            minimumPixelSize: 7
        }

        Rectangle {
            id: line
            height: 1 * AppController.windowScale
            width: text.width
            color: root.active ? Style.neon : Style.transparent
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
        cursorShape: Qt.PointingHandCursor
    }
}
