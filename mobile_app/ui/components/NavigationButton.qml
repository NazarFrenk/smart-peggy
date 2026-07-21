import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

import "../singletons"

CustomAbstractButton {
    id: root

    property color color: Style.black
    property color borderColor: Style.neon
    property int borderWidth: 1
    property string image: ""
    property string text: ""
    property color textColor: Style.neon

    Rectangle {
        id: background
        anchors.fill: parent
        radius: root.radius
        border.width: root.borderWidth
        border.color: root.borderColor
        color: root.color
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: LayoutDefaults.defaultScreenSpacing / 2

        ColoredImage {
            id: image
            Layout.alignment: Qt.AlignLeft
            Layout.fillHeight: true
            Layout.fillWidth: false
            Layout.preferredWidth: height

            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
            visible: root.image !== ""

            source: root.image
            overlayColor: root.textColor
        }

        Label {
            id: label
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            font.pixelSize: FontSize.medium
            //font.bold: root.fontBold
            text: root.text
            color: root.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            wrapMode: Text.WordWrap
        }
    }
}
