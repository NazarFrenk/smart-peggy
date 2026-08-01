import QtQuick
import QtQuick.Controls

import "../singletons"

Switch {
    id: control

    indicator: Rectangle {
        implicitWidth: 56
        implicitHeight: 28
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: height / 2

        color: control.checked ? Style.lavender : Style.grey
        border.color: "#D0D0D8"
        border.width: 1

        Rectangle {
            x: control.checked ? parent.width - width - 4 : 4
            y: parent.height / 2 - height / 2
            width: 20 * LayoutDefaults.displayScale
            height: 20 * LayoutDefaults.displayScale
            radius: width / 2
            color: Style.white

            Behavior on x {
                NumberAnimation { duration: 150 }
            }
        }
    }
}
