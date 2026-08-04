import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../singletons"
import "../components"

Page {
    id: root

    property bool bluetoothEnabled: true
    property bool scanning: false
    property bool connected: false
    property string currentDeviceName: "SmartPeggy Board 01"
    property string currentDeviceMac: "AA:BB:CC:DD:EE:01"

    ListModel {
        id: devices
        ListElement { name: "SmartPeggy Board 01"; mac: "AA:BB:CC:DD:EE:01"; status: "available" }
        ListElement { name: "SmartPeggy Board 02"; mac: "AA:BB:CC:DD:EE:02"; status: "available" }
        ListElement { name: "Other Device"; mac: "AA:BB:CC:DD:EE:03"; status: "available" }
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
            anchors.fill: parent
            anchors.margins: LayoutDefaults.defaultScreenSpacing * 1.5
            spacing: 0

            NavigationButton {
                id: backBtn
                Layout.preferredWidth: parent.height * 0.9
                Layout.preferredHeight: parent.height * 0.9
                radius: width / 2

                image: Icons.backArrow
                color: Style.softLavender
                borderColor: Style.transparent
                textColor: Style.lavender

                onClicked: {
                    mainStackView.pop()
                }
            }

            Label {
                text: qsTr("Bluetooth")
                font.pixelSize: FontSize.heading
                font.bold: true
                color: Style.black
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Button {
                id: notifBtn
                Layout.preferredWidth: parent.height * 0.9
                Layout.preferredHeight: parent.height * 0.9
                icon.source: Icons.notification || ""
                icon.color: Style.black
                background: Rectangle {
                    color: Style.transparent
                }
            }
        }
    }

    background: Rectangle {
        anchors.fill: parent;
        color: "#F8F8FA"
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            id: layout
            width: scrollView.availableWidth
            spacing: 24 * LayoutDefaults.displayScale
            Layout.alignment: Qt.AlignHCenter

            // 1. Status
            ModernCard {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.width - (32 * LayoutDefaults.displayScale)
                sectionTitle: qsTr("STATUS")
                content: Component {
                    RowLayout {
                        spacing: LayoutDefaults.defaultScreenSpacing * 1.5

                        Rectangle {
                            Layout.preferredWidth: 56 * LayoutDefaults.displayScale
                            Layout.preferredHeight: 56 * LayoutDefaults.displayScale
                            radius: width / 2
                            color: "#ECE6F6"
                            ColoredImage {
                                source: Icons.bluetooth
                                anchors.centerIn: parent
                                width: 28 * LayoutDefaults.displayScale
                                height: 28 * LayoutDefaults.displayScale
                                overlayColor: Style.lavender
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4 * LayoutDefaults.displayScale
                            Label {
                                text: root.bluetoothEnabled ? qsTr("Bluetooth Enabled") : qsTr("Bluetooth Disabled")
                                font.pixelSize: FontSize.body
                                font.bold: true
                            }
                            RowLayout {
                                spacing: 6 * LayoutDefaults.displayScale
                                Rectangle {
                                    width: 8 * LayoutDefaults.displayScale
                                    height: 8 * LayoutDefaults.displayScale
                                    radius: width / 2
                                    color: root.bluetoothEnabled ? Style.green : Style.error
                                }
                                Label {
                                    text: root.scanning ? qsTr("Scanning...") : qsTr("Ready to connect")
                                    font.pixelSize: FontSize.caption
                                    color: Style.grey
                                }
                            }
                        }

                        DelayedBusyIndicator {
                            running: root.scanning
                            Layout.preferredWidth: 24 * LayoutDefaults.displayScale
                            Layout.preferredHeight: 24 * LayoutDefaults.displayScale
                        }
                    }
                }
            }

            // 2. Scan button
            NavigationButton {
                id: scanButton
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.width - (32 * LayoutDefaults.displayScale)
                Layout.preferredHeight: 50 * LayoutDefaults.displayScale

                radius: LayoutDefaults.defaultRadius

                text: root.scanning ? qsTr("Stop Scanning") : qsTr("Start Scanning")
                image: Icons.search

                color: root.scanning ? Style.error : Style.lavender
                borderColor: Style.transparent
                textColor: Style.white

                onClicked: root.scanning = !root.scanning
            }

            // 3. Available devices
            ModernCard {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.width - (32 * LayoutDefaults.displayScale)
                sectionTitle: qsTr("AVAILABLE DEVICES")
                content: Component {
                    ColumnLayout {
                        spacing: LayoutDefaults.defaultScreenSpacing
                        Label {
                            text: devices.count > 0 ? qsTr("Tap to connect") : qsTr("No devices found")
                            font.pixelSize: FontSize.caption
                            color: Style.grey
                            Layout.fillWidth: true
                        }
                        ListView {
                            id: devicesListView
                            Layout.fillWidth: true
                            Layout.preferredHeight: contentItem.childrenRect.height > 0 ? contentItem.childrenRect.height : (120 * LayoutDefaults.displayScale)
                            interactive: false
                            model: devices
                            spacing: LayoutDefaults.defaultRadius

                            delegate: ItemDelegate {
                                width: devicesListView.width
                                implicitHeight: delegateLayout.implicitHeight + (16 * LayoutDefaults.displayScale)
                                background: Rectangle {
                                    color: Style.white
                                    radius: LayoutDefaults.defaultRadius
                                    border.color: "#F0F0F2"
                                    border.width: 1
                                }

                                contentItem: RowLayout {
                                    id: delegateLayout
                                    spacing: 12 * LayoutDefaults.displayScale

                                    Rectangle {
                                        Layout.preferredWidth: LayoutDefaults.defaultMargins * 3
                                        Layout.preferredHeight: LayoutDefaults.defaultMargins * 3
                                        radius: width / 2
                                        color: "#ECE6F6"
                                        ColoredImage {
                                            source: Icons.bluetooth
                                            anchors.centerIn: parent
                                            width: 18 * LayoutDefaults.displayScale
                                            height: 18 * LayoutDefaults.displayScale
                                            overlayColor: Style.lavender
                                        }
                                    }

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 2 * LayoutDefaults.displayScale
                                        Label {
                                            text: name
                                            font.pixelSize: FontSize.body
                                            font.bold: true
                                            Layout.fillWidth: true
                                        }
                                        Label {
                                            text: mac
                                            font.pixelSize: FontSize.caption
                                            color: Style.grey
                                            Layout.fillWidth: true
                                        }
                                    }
                                }

                                onClicked: {
                                    console.log("Connect to device", name, "with MAC", mac)
                                    root.connected = true
                                    root.currentDeviceName = name
                                    root.currentDeviceMac = mac
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
