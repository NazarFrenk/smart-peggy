pragma Singleton

import QtQuick
import smartpeggy

QtObject {
    readonly property real scale: AppController.windowScale * 1.2 * AppController.displayScale
    readonly property real displayScale: scale < 2 ? scale : 2

    readonly property int tiny: 6 * displayScale
    readonly property int caption: 8 * displayScale
    readonly property int small: 10 * displayScale
    readonly property int body: 12 * displayScale
    readonly property int bodyLarge: 15 * displayScale
    readonly property int subtitle: 17 * displayScale
    readonly property int heading: 19 * displayScale
    readonly property int title: 24 * displayScale
    readonly property int display: 32 * displayScale
    readonly property int hero: 50 * displayScale
}
