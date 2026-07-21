import QtQuick

import "../singletons"

Rectangle {
    id: root

    required property real size
    property string status: "ok"

    width: root.size
    height: root.size

    radius: Math.min(width, height) / 2

    color: {
        switch (status) {
        case "ok":    return Style.green
        case "warn":  return Style.yellow
        case "error": return Style.red
        default:      return Style.grey
        }
    }

    border.color: Qt.darker(color, 1.3)
    border.width: Math.max(1, Math.min(width, height) * 0.08)
}
