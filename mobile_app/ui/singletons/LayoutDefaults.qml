pragma Singleton

import QtQuick
import smartpeggy

QtObject {
    readonly property real displayScale: AppController.displayScale

    readonly property real defaultWindowHeight: 600 * displayScale
    readonly property real defaultWindowWidth: 1024 * displayScale

    readonly property real minWindowHeight: 600 * displayScale
    readonly property real minWindowWidth: 1024 * displayScale

    readonly property real defaultRadius: 8 * displayScale
    readonly property real defaultScreenSpacing: 10 * displayScale

    readonly property real scrollWidth: 4 * displayScale
}
