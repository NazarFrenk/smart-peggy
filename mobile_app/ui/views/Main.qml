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
}
