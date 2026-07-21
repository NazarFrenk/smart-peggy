import QtQuick
import QtQuick.Controls.Basic

import "../singletons"

ScrollBar {
    id: root

    property color contentColor: Style.neon
    property color backgroundColor: Style.white

    contentItem: Rectangle {
        implicitWidth: 4
        implicitHeight: 100
        radius: width / 2
        color: root.contentColor
    }

    Rectangle {
        anchors.fill: root
        color: root.backgroundColor
        opacity: 0.4
        radius: root.width / 2
    }
}
