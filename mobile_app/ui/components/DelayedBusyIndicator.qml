import QtQuick
import QtQuick.Controls.Basic

Rectangle {
    id: root

    color: "transparent"

    property bool running: true
    visible: root.running

    onVisibleChanged: {
        if(visible){
            delayTimer.start()
        }else
        {
            delayTimer.stop()
        }
    }

    Timer {
        id: delayTimer
        interval: 200;
        running: false
        repeat: false
    }

    readonly property int itemSize: Math.min(root.width, root.height)

    BusyIndicator
    {
        anchors.centerIn: parent
        width: root.itemSize
        height: root.itemSize
        running: root.running && !delayTimer.running
    }
}
