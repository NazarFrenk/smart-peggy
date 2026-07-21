import QtQuick
import QtQuick.Controls.Basic

import "../singletons"

ProgressBar {
    id: root

    property color contentColor: Style.neon
    property color backgroundColor: Style.grey

    background: Rectangle {
        color: root.backgroundColor
        radius: height / 2
    }

    contentItem: Item {
        clip: true
        Rectangle {
            width: root.visualPosition * root.width
            height: root.height
            color: root.contentColor
            radius: height / 2
        }
    }
}
