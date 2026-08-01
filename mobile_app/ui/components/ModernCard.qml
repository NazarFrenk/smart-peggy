import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "../singletons"

ColumnLayout {
    id: root
    spacing: 8

    property string sectionTitle: ""
    property alias content: contentLoader.sourceComponent

    // Label for header
    Label {
        text: root.sectionTitle
        font.pixelSize: FontSize.caption
        color: Style.lavender
        visible: root.sectionTitle !== ""
        Layout.fillWidth: true
        Layout.leftMargin: 16
    }

    // Card content
    Item {
        id: cardContainer
        Layout.fillWidth: true

        implicitHeight: (contentLoader.item ? contentLoader.item.implicitHeight : 0) + 32

        Glow {
            id: shadow
            anchors.fill: cardBackground
            radius: LayoutDefaults.defaultRadius
            samples: 17
            color: "#20000000"
            source: cardBackground
            visible: true
        }

        Rectangle {
            id: cardBackground
            anchors.fill: parent
            anchors.margins: 4
            color: Style.white
            radius: LayoutDefaults.defaultRadius * 1.5
            // border.color: "#E0E0E0"
            // border.width: 1

            Loader {
                id: contentLoader
                anchors.fill: parent
                anchors.margins: 16
            }
        }
    }
}
