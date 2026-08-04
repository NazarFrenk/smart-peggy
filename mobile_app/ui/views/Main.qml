import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../singletons"
import "../components"

ApplicationWindow {
    id: root

    width: LayoutDefaults.designWidth
    height: LayoutDefaults.designHeight

    visible: true

    // Keep the window background opaque during Surface recreation.
    color: Style.black

    property alias mainStack: mainStackView

    // Trigger an extra render pass after the application resumes.
    Timer {
        id: resumeRenderTimer
        interval: 120
        repeat: false
        onTriggered: {
            root.opacity = 0.99
            opacityRestoreTimer.restart()
        }
    }

    Timer {
        id: opacityRestoreTimer
        interval: 40
        repeat: false
        onTriggered: root.opacity = 1.0
    }

    Connections {
        target: Qt.application

        function onStateChanged() {
            if (Qt.application.state === Qt.ApplicationActive) {
                resumeRenderTimer.restart()
                root.requestUpdate()
            }
        }
    }

    StackView {
        id: mainStackView
        anchors.fill: parent

        initialItem: homePageComponent
    }

    Component {
        id: homePageComponent

        HomePage {
            id: homePage
        }
    }
}
