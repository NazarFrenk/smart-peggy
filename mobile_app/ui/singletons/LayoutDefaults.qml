pragma Singleton

import QtQuick
import smartpeggy

QtObject {
    readonly property real displayScale: AppController.displayScale

    readonly property real designWidth: 360
    readonly property real designHeight: 640

    readonly property real defaultRadius: 8 * displayScale
    readonly property real defaultScreenSpacing: 10 * displayScale

    readonly property real scrollWidth: 4 * displayScale
}
