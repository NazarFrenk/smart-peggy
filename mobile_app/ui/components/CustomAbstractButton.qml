import QtQuick

Item {
    id: root
    property bool rotaryArrovsVisible: false
    readonly property bool pressed: mouseArea.pressed
    property int radius
    property bool wheelEnabled: true

    //need to use variant here as we pass both MouseEvent and KeyEvent.
    //users connecting to this signal assume the event has an 'accepted' property.
    signal clicked(var mouse)
    signal pressAndHold(var mouse)
    signal released(var mouse)
    signal up()
    signal down()

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: true
        enabled: true
        acceptedButtons: Qt.LeftButton

        onClicked: function(mouse) {
            mouse.accepted = true;
            root.clicked(mouse);
        }
        onPressAndHold: function(mouse) {
            mouse.accepted = true;
            root.pressAndHold(mouse);
        }
        onReleased: function(mouse) {
            mouse.accepted = true;
            root.released(mouse);
        }
        onWheel: function(wheel) {
            if(root.wheelEnabled){
                if(wheel.angleDelta.y>0)
                    root.up()
                else
                    if(wheel.angleDelta.y<0)
                        root.down()
            } else {
                wheel.accepted = false
            }
        }
    }

    Keys.onPressed: function(event) {
        switch (event.key) {
        case Qt.Key_Return:
            event.accepted = true;
            root.clicked(event);
            break;
        case Qt.Key_Up:
            event.accepted = true;
            root.up()
            break;
        case Qt.Key_Down:
            event.accepted = true;
            root.down()
            break;
        }
    }
}
