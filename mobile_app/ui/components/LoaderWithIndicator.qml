import QtQuick

import "../singletons"

Item {
    id: root

    property alias sourceComponent: loader.sourceComponent
    property alias active: loader.active
    property var item: loader.status === Loader.Ready && loader.item ? loader.item : null

    property color indicatorColor: Style.neon
    property bool asynchronous: true

    DelayedBusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        width: root.width/2
        height: root.height/2
        palette.dark: root.indicatorColor
        running: loader.status === Loader.Loading && loader.active
    }

    Loader {
        id: loader

        anchors.fill: parent

        asynchronous: root.asynchronous
    }
}
