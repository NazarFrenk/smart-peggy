import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../singletons"

Item {
    id: root

    required property string title
    property alias content: contentLoader.sourceComponent

    Rectangle {
        id: background
        anchors.fill: parent
        color: Style.pastelYellow
        border.color: Style.lavender
        border.width: 1
        radius: LayoutDefaults.defaultRadius

        Loader {
            id: contentLoader
            anchors.fill: parent
            anchors.margins: LayoutDefaults.defaultScreenSpacing / 2
        }
    }

    Rectangle {
        id: titleRect
        height: titleText.height * 1.1
        width: titleText.width * 1.1
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -height / 2
        anchors.leftMargin: 12

        border.color: Style.lavender
        border.width: 1
        color: background.color

        Text {
            id: titleText
            text: root.title
            color: Style.lavender
            font.pixelSize: FontSize.caption
            font.bold: true
            anchors.centerIn: parent
        }
    }
}
