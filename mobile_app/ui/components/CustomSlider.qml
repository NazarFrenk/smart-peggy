import QtQuick
import QtQuick.Controls

import "../singletons"

Slider {
    id: control

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: width / 2
        color: Style.white
        border.color: Style.lavender
        border.width: 2
    }

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 6
        width: control.availableWidth
        height: implicitHeight
        radius: height / 2
        color: Style.softLavender

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: Style.lavender
            radius: height / 2
        }
    }
}
