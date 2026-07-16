pragma Singleton

import QtQuick
import smartpeggy

QtObject {
    readonly property real scale: AppController.windowScale * 1.2 * AppController.displayScale
    readonly property real displayScale: scale < 2 ? scale : 2

    readonly property int minimum: 6 * displayScale
    readonly property int xMinimum: 8 * displayScale
    readonly property int small: 10 * displayScale
    readonly property int medium: 12 * displayScale
    readonly property int medium2: 15 * displayScale
    readonly property int xMedium: 17 * displayScale
    readonly property int xxMedium: 19 * displayScale
    readonly property int large: 24 * displayScale
    readonly property int xLarge: 32 * displayScale
    readonly property int huge: 50 * displayScale
}
