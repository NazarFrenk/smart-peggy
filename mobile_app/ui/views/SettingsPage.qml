import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../singletons"
import "../components"

Page {
    id: root

    property bool isConnected: false
    property string connectedDeviceName: ""

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
                text: qsTr("Settings")
                font.pixelSize: FontSize.heading
                font.bold: true
                color: Style.black
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Item { Layout.preferredWidth: 40; Layout.fillHeight: true }
        }
    }

    background: Rectangle {
        anchors.fill: parent
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
            spacing: 24
            Layout.alignment: Qt.AlignHCenter

            // Language section
            ModernCard {
                id: languageGb
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.width - 32
                sectionTitle: qsTr("LANGUAGE")

                content: Component {
                    RowLayout {
                        spacing: 16

                        Rectangle {
                            Layout.preferredWidth: 40
                            Layout.preferredHeight: 40
                            radius: 20
                            color: "#ECE6F6"
                            ColoredImage {
                                source: Icons.language
                                anchors.centerIn: parent
                                width: 20;
                                height: 20
                                overlayColor: Style.lavender
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: LayoutDefaults.defaultRadius

                            Label {
                                text: qsTr("App Language")
                                font.pixelSize: FontSize.body
                                font.bold: true
                                color: Style.black
                            }

                            ComboBox {
                                id: lngCb
                                Layout.fillWidth: true
                                textRole: "text"

                                activeFocusOnTab: false
                                focus: false

                                background: Rectangle {
                                    implicitWidth: 120
                                    implicitHeight: 40
                                    color: Style.white
                                    radius: LayoutDefaults.defaultRadius
                                    border.color: lngCb.activeFocus ? Style.lavender : "#F0F0F2"
                                    border.width: 1
                                }

                                model: ListModel {
                                    ListElement { text: "System (default)"; value: 0 }
                                    ListElement { text: "Ukrainian"; value: 1 }
                                    ListElement { text: "English"; value: 2 }
                                    ListElement { text: "Russian"; value: 3 }
                                }
                                delegate: ItemDelegate {
                                    width: lngCb.width
                                    contentItem: Text {
                                        text: model.text
                                        color: Style.black
                                        font: lngCb.font
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    background: Rectangle {
                                        color: lngCb.highlightedIndex === index ? Style.softLavender : Style.transparent
                                    }
                                }
                                onActivated: (index) => {
                                                 console.log("Language selected index:", index, "value:", textAt(index))
                                             }
                            }
                        }
                    }
                }
            }

            // Section Device Connection
            ModernCard {
                id: bluetoothCard
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.width - 32
                sectionTitle: qsTr("DEVICE CONNECTION")

                content: Component {
                    Item {
                        implicitWidth: btRowLayout.implicitWidth
                        implicitHeight: btRowLayout.implicitHeight

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (typeof mainStackView !== "undefined" && mainStackView !== null) {
                                    mainStackView.push(Qt.resolvedUrl("BluetoothPage.qml"))
                                } else {
                                    console.warn("mainStackView is not available")
                                }
                            }

                            RowLayout {
                                id: btRowLayout
                                width: parent.width
                                spacing: 16

                                Rectangle {
                                    Layout.preferredWidth: 40
                                    Layout.preferredHeight: 40
                                    radius: 20
                                    color: "#ECE6F6"
                                    ColoredImage {
                                        source: Icons.bluetooth
                                        anchors.centerIn: parent
                                        width: 20;
                                        height: 20
                                        overlayColor: Style.lavender
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2
                                    Label {
                                        text: qsTr("Bluetooth")
                                        font.pixelSize: FontSize.body
                                        font.bold: true
                                        color: Style.black
                                    }
                                    Label {
                                        text: (typeof root.isConnected !== "undefined" && root.isConnected && root.connectedDeviceName !== "")
                                              ? root.connectedDeviceName
                                              : qsTr("Not connected")
                                        font.pixelSize: FontSize.caption
                                        color: (typeof root.isConnected !== "undefined" && root.isConnected) ? Style.green : Style.grey
                                    }
                                }

                                ColoredImage {
                                    source: Icons.backArrow
                                    rotation: 180
                                    overlayColor: Style.black
                                    Layout.preferredWidth: 16
                                    Layout.preferredHeight: 16
                                }
                            }
                        }
                    }
                }
            }

            // spacer
            Item {
                Layout.fillHeight: true
            }
        }
    }
}
