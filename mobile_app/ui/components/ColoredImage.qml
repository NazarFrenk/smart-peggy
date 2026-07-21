import QtQuick

import "../singletons"

Item {
    id: root

    required property color overlayColor
    required property string source

    property alias sourceSize: image.sourceSize
    property alias asynchronous: image.asynchronous
    property alias mirror: image.mirror

    property real rotation: 0
    property int fillMode: Image.PreserveAspectFit

    Image {
        id: image
        anchors.fill: parent
        fillMode: root.fillMode
        source: root.source
        smooth: true
        antialiasing: root.antialiasing
        asynchronous: true
        sourceSize.width: root.height
        sourceSize.height: root.height
        rotation: root.rotation
        cache: true
    }

    ShaderEffectSource {
        id: theSource
        sourceItem: image
        hideSource: root.overlayColor !== Style.transparent
    }

    ShaderEffect {
        anchors.fill: parent
        visible: root.overlayColor !== Style.transparent

        property color tint: root.overlayColor
        property variant source: theSource

        fragmentShader: "qrc:/shaders/colorize.frag.qsb"
        rotation: root.rotation
        opacity: root.opacity
    }
}
