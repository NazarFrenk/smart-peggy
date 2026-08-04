import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../singletons"
import "../components"

Page {
    id: root

    background: Rectangle {
        anchors.fill: parent
        color: "#F8F8FA"
    }

    header: ToolBar {
        id: toolBar
        implicitHeight: 70 * LayoutDefaults.displayScale
        background: Rectangle {
            gradient: Gradient {
                GradientStop { position: 0.0; color: Style.softLavender }
                GradientStop { position: 1.0; color: Style.white }
            }
        }

        RowLayout {
            id: barLayout
            anchors.fill: parent
            anchors.margins: LayoutDefaults.defaultScreenSpacing * 1.5
            spacing: 0

            RowLayout {
                spacing: LayoutDefaults.defaultScreenSpacing
                Layout.fillHeight: true

                Rectangle {
                    Layout.preferredWidth: barLayout.height
                    Layout.preferredHeight: barLayout.height
                    radius: width / 2
                    color: Style.softLavender

                    ColoredImage {
                        source: Icons.lighthouse
                        anchors.centerIn: parent
                        width: LayoutDefaults.defaultMargins * 3
                        height: LayoutDefaults.defaultMargins * 3
                        overlayColor: Style.lavender
                    }
                }

                Label {
                    text: qsTr("Smart Peggy")
                    font.pixelSize: FontSize.heading
                    font.bold: true
                    color: Style.black
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Item { Layout.fillWidth: true }

            NavigationButton {
                id: settingsBtn
                Layout.preferredWidth: 44 * LayoutDefaults.displayScale
                Layout.preferredHeight: 44 * LayoutDefaults.displayScale
                radius: width / 2

                image: Icons.settings
                color: Style.softLavender
                borderColor: Style.transparent
                textColor: Style.lavender

                onClicked: {
                    mainStackView.push(Qt.resolvedUrl("SettingsPage.qml"))
                }
            }
        }
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            id: layout
            width: scrollView.availableWidth
            spacing: LayoutDefaults.defaultScreenSpacing * 2.5

            Layout.alignment: Qt.AlignHCenter

            // Section 1: BEAM CONTROL
            ModernCard {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.width - (32 * LayoutDefaults.displayScale)
                sectionTitle: qsTr("SECTION 1: BEAM CONTROL")

                content: Component {
                    ColumnLayout {
                        spacing: LayoutDefaults.defaultRadius * 2
                        Layout.fillWidth: true

                        Rectangle {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: 180 * LayoutDefaults.displayScale
                            Layout.preferredHeight: 180 * LayoutDefaults.displayScale
                            radius: width / 2
                            color: "#F4F2FA"
                            border.color: Style.lavender
                            border.width: 2

                            Rectangle {
                                anchors.centerIn: parent
                                width: 120 * LayoutDefaults.displayScale
                                height: 120 * LayoutDefaults.displayScale
                                radius: width / 2
                                color: Style.white
                                border.color: "#E0E0E8"
                                border.width: 1

                                ColoredImage {
                                    source: Icons.lighthouse
                                    anchors.centerIn: parent
                                    width: 60 * LayoutDefaults.displayScale
                                    height: 60 * LayoutDefaults.displayScale
                                    overlayColor: Style.lavender
                                }
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: LayoutDefaults.defaultRadius
                            Layout.rightMargin: LayoutDefaults.defaultRadius

                            Label {
                                text: qsTr("AUTO-SPIN")
                                font.bold: true
                                font.pixelSize: FontSize.body
                                color: Style.black
                                Layout.fillWidth: true
                            }

                            CustomSwitch {
                                checked: true
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: LayoutDefaults.defaultRadius
                            Layout.rightMargin: LayoutDefaults.defaultRadius
                            spacing: 6 * LayoutDefaults.displayScale

                            Label {
                                text: qsTr("SPEED")
                                font.pixelSize: FontSize.caption
                                color: Style.grey
                            }

                            CustomSlider {
                                Layout.fillWidth: true
                                from: 0
                                to: 100
                                value: 45
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: LayoutDefaults.defaultRadius
                            Layout.rightMargin: LayoutDefaults.defaultRadius
                            spacing: 6 * LayoutDefaults.displayScale

                            Label {
                                text: qsTr("BRIGHTNESS");
                                font.pixelSize: FontSize.caption;
                                color: Style.grey
                            }

                            CustomSlider {
                                Layout.fillWidth: true;
                                value: 80
                            }
                        }
                    }
                }
            }

            // Section 2: LIGHTING ZONES (Zones A, B, C)
            ModernCard {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.width - (32 * LayoutDefaults.displayScale)
                sectionTitle: qsTr("SECTION 2: LIGHTING ZONES")

                content: Component {
                    ColumnLayout {
                        spacing: LayoutDefaults.defaultRadius * 2
                        Layout.fillWidth: true

                        // Zone А: BEACON PROJECTOR
                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: zoneALayout.implicitHeight + (LayoutDefaults.defaultMargins * 2)
                            color: Style.white
                            radius: LayoutDefaults.defaultRadius
                            border.color: "#F0F0F2"
                            border.width: 1

                            ColumnLayout {
                                id: zoneALayout
                                anchors.fill: parent
                                anchors.margins: LayoutDefaults.defaultMargins
                                spacing: LayoutDefaults.defaultMargins

                                RowLayout {
                                    Layout.fillWidth: true
                                    Label {
                                        text: qsTr("ZONE A:\nBEACON PROJECTOR")
                                        font.bold: true
                                        font.pixelSize: FontSize.body
                                        color: Style.black
                                        Layout.fillWidth: true
                                    }

                                    CustomSwitch {
                                        id: beaconSwitch

                                        checked: true
                                    }
                                }

                                RowLayout {
                                    id: projectorLayout

                                    Layout.fillWidth: true

                                    spacing: LayoutDefaults.defaultRadius

                                    NavigationButton {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: LayoutDefaults.defaultMargins * 3
                                        text: qsTr("Constant")
                                        image: Icons.sun
                                        color: Style.lavender
                                        textColor: Style.white
                                        borderColor: Style.transparent
                                    }

                                    NavigationButton {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: LayoutDefaults.defaultMargins * 3
                                        text: qsTr("Strobe")
                                        image: Icons.strobe
                                        color: Style.softLavender
                                        textColor: Style.black
                                        borderColor: Style.transparent
                                    }

                                    NavigationButton {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: LayoutDefaults.defaultMargins * 3
                                        text: qsTr("SOS")
                                        image: Icons.strobe
                                        color: Style.softLavender
                                        textColor: Style.black
                                        borderColor: Style.transparent
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4

                                    Label {
                                        text: qsTr("BRIGHTNESS");
                                        font.pixelSize: FontSize.caption;
                                        color: Style.grey
                                    }

                                    CustomSlider {
                                        Layout.fillWidth: true;
                                        value: 80
                                    }
                                }
                            }
                        }

                        // Zone B: LANTERNS
                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: zoneBLayout.implicitHeight + (LayoutDefaults.defaultMargins * 2)
                            color: Style.white
                            radius: LayoutDefaults.defaultRadius
                            border.color: "#F0F0F2"
                            border.width: 1

                            ColumnLayout {
                                id: zoneBLayout
                                anchors.fill: parent
                                anchors.margins: LayoutDefaults.defaultMargins
                                spacing: LayoutDefaults.defaultMargins

                                RowLayout {
                                    Layout.fillWidth: true

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2

                                        Label {
                                            text: qsTr("ZONE B:")
                                            font.pixelSize: FontSize.caption
                                            color: Style.grey
                                        }

                                        Label {
                                            text: qsTr("LANTERNS")
                                            font.bold: true
                                            font.pixelSize: FontSize.body
                                            color: Style.black
                                        }

                                        Label {
                                            text: qsTr("Garden Lights")
                                            font.pixelSize: FontSize.small
                                            color: Style.black
                                        }
                                    }

                                    Item {
                                        Layout.fillWidth: true
                                    }

                                    CustomSwitch {
                                        checked: true
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4

                                    Label {
                                        text: qsTr("BRIGHTNESS");
                                        font.pixelSize: FontSize.caption;
                                        color: Style.grey
                                    }

                                    CustomSlider {
                                        Layout.fillWidth: true;
                                        value: 60
                                    }
                                }
                            }
                        }

                        // Zone C: PATHWAY GUIDE
                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: zoneCLayout.implicitHeight + (LayoutDefaults.defaultMargins * 2)
                            color: Style.white
                            radius: LayoutDefaults.defaultRadius
                            border.color: "#F0F0F2"
                            border.width: 1

                            ColumnLayout {
                                id: zoneCLayout
                                anchors.fill: parent
                                anchors.margins: LayoutDefaults.defaultMargins
                                spacing: LayoutDefaults.defaultMargins

                                RowLayout {
                                    Layout.fillWidth: true

                                    Label {
                                        text: qsTr("ZONE C:\nPATHWAY GUIDE")
                                        font.bold: true
                                        font.pixelSize: FontSize.body
                                        color: Style.black
                                        Layout.fillWidth: true
                                    }

                                    CustomSwitch {
                                        checked: true
                                    }
                                }

                                RowLayout {

                                    spacing: LayoutDefaults.defaultRadius

                                    NavigationButton {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: LayoutDefaults.defaultMargins * 3
                                        text: qsTr("Steady")
                                        image: Icons.pathway
                                        color: Style.lavender
                                        textColor: Style.white
                                        borderColor: Style.transparent
                                    }

                                    NavigationButton {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: LayoutDefaults.defaultMargins * 3
                                        text: qsTr("Wave")
                                        image: Icons.wave
                                        color: Style.softLavender
                                        textColor: Style.black
                                        borderColor: Style.transparent
                                    }

                                    NavigationButton {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: LayoutDefaults.defaultMargins * 3
                                        text: qsTr("Pulse")
                                        image: Icons.strobe
                                        color: Style.softLavender
                                        textColor: Style.black
                                        borderColor: Style.transparent
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4

                                    Label {
                                        text: qsTr("BRIGHTNESS");
                                        font.pixelSize: FontSize.caption;
                                        color: Style.grey
                                    }

                                    CustomSlider {
                                        Layout.fillWidth: true;
                                        value: 40
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item { Layout.preferredHeight: 16 * LayoutDefaults.displayScale }
        }
    }

    footer: ToolBar {

        implicitHeight: 45 * LayoutDefaults.displayScale

        background: Rectangle {
            color: Style.white
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: LayoutDefaults.defaultRadius * 2
            anchors.rightMargin: LayoutDefaults.defaultRadius * 2

            Label {
                id: deviceName
                text: qsTr("Lighthouse_BLE")
                color: Style.lightSkyBlue
                font.bold: true
                font.pixelSize: FontSize.caption
            }

            Label {
                id: connectionStatus
                text: qsTr("connected")
                color: Style.green
                font.bold: true
                font.pixelSize: FontSize.caption
            }

            Item { Layout.fillWidth: true }

            // Battery indicator
            RowLayout {
                id: battery
                spacing: LayoutDefaults.defaultRadius

                property int batteryLevel: 75 // TODO - NF: get battery lvl

                Label {
                    text: parent.batteryLevel + "%"
                    font.pixelSize: FontSize.caption
                    color: Style.black
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: batteryOutline
                    width: LayoutDefaults.defaultMargins * 2
                    height: LayoutDefaults.defaultMargins
                    radius: 3
                    color: Style.transparent

                    border.color: battery.batteryLevel <= 20 ? Style.red : (battery.batteryLevel <= 50 ? Style.yellow : Style.green)
                    border.width: 1

                    Rectangle {
                        id: batteryFill
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 2

                        width: (parent.width - 4) * (Math.max(0, Math.min(100, battery.batteryLevel)) / 100)
                        radius: 1

                        color: battery.batteryLevel <= 20 ? Style.red : (battery.batteryLevel <= 50 ? Style.yellow : Style.green)

                        Behavior on width {
                            NumberAnimation { duration: 300 }
                        }
                    }

                    Rectangle {
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width: 2 * LayoutDefaults.displayScale
                        height: 5 * LayoutDefaults.displayScale
                        radius: 1
                        color: batteryOutline.border.color
                    }
                }
            }
        }
    }
}
